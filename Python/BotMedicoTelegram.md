**

# Guía Técnica y Conceptual: Bot de Triaje Médico con Arquitectura Human-in-the-Loop

---

Este documento desglosa paso a paso la arquitectura, la lógica de programación y el flujo de ejecución del bot de triaje médico multimodal desarrollado en Python. El objetivo de este sistema es asistir en la recolección de datos y generación de borradores clínicos estructurados (SOAP) manteniendo el control médico absoluto antes de emitir cualquier respuesta al paciente.

## 1. Visión Panorámica y Filosofía de Diseño

El sistema se fundamenta en tres pilares esenciales:

- Arquitectura Human-in-the-Loop (Médico en el Bucle): El modelo de inteligencia artificial (LLM local) nunca responde de forma autónoma o directa al paciente con consejos médicos. Su rol es exclusivamente actuar como un "residente digital" que toma notas, transcribe, extrae información y redacta un borrador preliminar.
    
- Procesamiento Multimodal Local: La información del paciente puede provenir de mensajes de texto, notas de voz (audio), documentos analíticos (PDF) e imágenes. Todo el procesamiento corre en la máquina local (vía Whisper y Ollama), protegiendo la confidencialidad de los datos de salud.
    
- Modularidad en Python: El proyecto se divide en módulos especializados para mantener el código desacoplado, legible y fácil de escalar hacia arquitecturas multi-agente más avanzadas (inspiradas en Google AMIE).
    

## 2. Estructura de Módulos del Proyecto

|Archivo / Módulo|Responsabilidad Principal|Librerías Clave|
|---|---|---|
|.env|Almacenamiento seguro de credenciales e identificadores del sistema fuera del código.|Texto plano / Clave-Valor|
|config.py|Carga, validación de variables de entorno y definición de rutas del sistema.|os, dotenv|
|multimodal.py|Pipeline de extracción y traducción sensorial: audio a texto, PDF a texto e imagen a descripción.|whisper, pypdf, ollama|
|llm_engine.py|Cerebro analítico: estructuración de la historia clínica en formato SOAP mediante Ollama.|ollama|
|main.py|Orquestador asíncrono del bot de Telegram, gestión de sesiones y ruteo de mensajes paciente-médico.|python-telegram-bot|

## 3. Análisis Detallado Módulo por Módulo

### 3.1. Módulo de Configuración (config.py)

Este archivo centraliza todos los parámetros operativos. Evita tener que escribir tokens y constantes repetidamente en el código.

import os  
from dotenv import load_dotenv  
  
# Carga las variables definidas en el archivo oculto .env  
load_dotenv()  
  
# Asignación a constantes globales de Python  
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")  
DOCTOR_TELEGRAM_ID = int(os.getenv("DOCTOR_TELEGRAM_ID", "0"))  
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "qwen3:8b")  
WHISPER_MODEL = os.getenv("WHISPER_MODEL", "small")  
  
# Creación automática de la carpeta temporal para descargas  
TEMP_DIR = os.path.join(os.path.dirname(__file__), "temp")  
os.makedirs(TEMP_DIR, exist_ok=True)  
  

#### Conceptos Clave de Python:

- load_dotenv(): Lee el archivo .env y expone sus valores al sistema operativo.
    
- os.getenv(clave, valor_por_defecto): Obtiene el valor como cadena de texto (string).
    
- int(...): Realiza un casteo de tipo de dato a entero, indispensable para que Telegram identifique correctamente tu ID numérico.
    
- os.makedirs(..., exist_ok=True): Crea el directorio temp/ si no existe previamente, sin arrojar error si ya fue creado.
    

### 3.2. Módulo de Ingesta Multimodal (multimodal.py)

Permite al sistema "escuchar", "leer" y "ver". Transforma archivos multimedia complejos en cadenas de texto estándar para que el LLM pueda procesarlos.

import whisper  
from pypdf import PdfReader  
import ollama  
from config import WHISPER_MODEL  
  
# 1. Carga del modelo Whisper en memoria RAM/GPU al arrancar  
_whisper_model = whisper.load_model(WHISPER_MODEL)  
  
def transcribir_audio(ruta_audio: str) -> str:  
    try:  
        resultado = _whisper_model.transcribe(ruta_audio, language="es")  
        texto = str(resultado.get("text", ""))  
        return texto.strip()  
    except Exception as e:  
        return f"[Error al transcribir audio: {e}]"  
  
def extraer_texto_pdf(ruta_pdf: str) -> str:  
    try:  
        reader = PdfReader(ruta_pdf)  
        texto_paginas = []  
        for i, pagina in enumerate(reader.pages):  
            texto = pagina.extract_text()  
            if texto:  
                texto_paginas.append(f"--- Página {i + 1} ---\n{texto}")  
        return "\n".join(texto_paginas) if texto_paginas else "[PDF sin texto legible directo]"  
    except Exception as e:  
        return f"[Error al leer PDF: {e}]"  
  

#### Conceptos Clave de Python:

- Whisper en memoria global (_whisper_model): Cargar el modelo una sola vez al inicio evita demoras de 5 a 10 segundos en cada nota de voz.
    
- Manejo de excepciones (try / except): Si un archivo está dañado o falla la decodificación, el programa no se cierra abruptamente; captura el error y devuelve un mensaje informativo.
    
- List Comprehension & str.join(): En extraer_texto_pdf, las páginas se van acumulando en una lista y se unen al final con saltos de línea (\n), lo que optimiza el uso de memoria en documentos extensos.
    

### 3.3. Motor de Razonamiento Clínico (llm_engine.py)

Define la estructura del informe y gobierna el comportamiento del LLM mediante un System Prompt clínico especializado.

import ollama  
from config import OLLAMA_MODEL  
  
SYSTEM_PROMPT_MEDICO = """  
Eres un asistente clínico de triaje médico basado en la metodología AMIE.  
Tu tarea es estructurar un INFORME PRELIMINAR DE TRIAJE para revisión del médico responsable.  
  
Debes seguir estrictamente este formato:  
1. MOTIVO DE CONSULTA Y ANAMNESIS (Subjetivo)  
2. HALLAZGOS Y DATOS ADJUNTOS (Objetivo)  
3. HIPÓTESIS DIAGNÓSTICAS / EVALUACIÓN (Assessment)  
4. PROPUESTA DE PLAN Y MANEJO (Plan)  
"""  
  
def generar_informe_clinico(datos_paciente: dict) -> str:  
    contenido_paciente = []  
    if datos_paciente.get("texto"):  
        contenido_paciente.append(f"--- MENSAJES DE TEXTO ---\n{datos_paciente['texto']}")  
    if datos_paciente.get("audios"):  
        contenido_paciente.append(f"--- TRANSCRIPCIÓN DE AUDIOS ---\n{datos_paciente['audios']}")  
    if datos_paciente.get("documentos"):  
        contenido_paciente.append(f"--- INFORMES PDF ---\n{datos_paciente['documentos']}")  
     
    prompt_usuario = "\n\n".join(contenido_paciente)  
     
    respuesta = ollama.chat(  
        model=OLLAMA_MODEL,  
        messages=[  
            {"role": "system", "content": SYSTEM_PROMPT_MEDICO},  
            {"role": "user", "content": prompt_usuario},  
        ],  
        options={"temperature": 0.2}  
    )  
    return respuesta["message"]["content"]  
  

#### Conceptos Clave de Python y LLM:

- Formato SOAP: Estándar médico internacional que divide la nota en Subjetivo (relato del paciente), Objetivo (analíticas y signos), Evaluación (juicio clínico) y Plan (conducta terapéutica).
    
- Temperatura Baja (0.2): Reduce la creatividad y variabilidad del modelo, obligándolo a ser determinista, factual y apegado a la evidencia descrita.
    
- Inferencia Local vía Ollama: El paquete ollama se comunica directamente mediante socket/HTTP con el motor Ollama en macOS sin enviar ningún dato a servidores externos.
    

### 3.4. Orquestador de Telegram y Ruteo (main.py)

Gestiona la interacción asíncrona, organiza los mensajes recibidos por cada paciente y envía el borrador al médico.

from collections import defaultdict  
from telegram import Update  
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, filters, ContextTypes  
  
# Diccionario con valores por defecto para no generar errores de clave inexistente  
sesiones_pacientes = defaultdict(lambda: {"texto": [], "audios": [], "documentos": [], "imagenes": []})  
  

#### Flujo de Trabajo del Orquestador:

1. Recepción Continua: El paciente envía uno o múltiples mensajes (texto, audios, fotos). Cada elemento se procesa y se añade a la lista correspondiente en sesiones_pacientes[user_id].
    
2. Comando /finalizar:
    

- Agrupa todo el texto, transcripciones y extracciones en una sola estructura consolidada.
    
- Llama a generar_informe_clinico().
    
- Envía un mensaje privado a tu chat de médico (DOCTOR_TELEGRAM_ID) con el formato estructurado y el ID del paciente.
    

3. Comando /responder <id> <texto>:
    

- El médico lee el informe, lo valida o ajusta su criterio clínico, y escribe el comando de respuesta.
    
- El bot extrae el ID del destinatario y le entrega el mensaje final firmado por el médico.
    
- Limpia la memoria temporal de la sesión para dejar listo al paciente para futuras consultas.
    

## 4. Diagrama del Flujo de Datos

|Paso|Actor / Componente|Acción / Resultado|
|---|---|---|
|1|Paciente (Móvil Secundario)|Envía texto, audios (.ogg) o PDFs con sus síntomas.|
|2|Bot de Telegram (main.py)|Descarga temporalmente los archivos en temp/.|
|3|Módulo multimodal.py|Whisper transcribe el audio a texto; PyPDF extrae tablas y valores. Borra archivos temporales.|
|4|Paciente|Envía /finalizar.|
|5|Módulo llm_engine.py|Qwen en Ollama procesa la información y genera la nota SOAP con diagnósticos diferenciales.|
|6|Médico (Móvil Principal)|Recibe el borrador SOAP con el ID del paciente en Telegram.|
|7|Médico|Envía /responder <ID> <Mensaje Validado>.|
|8|Paciente|Recibe la indicación médica final aprobada por el profesional.|

Conclusión del Estado Actual: Has implementado con éxito la base funcional de un asistente clínico local. La estructura es completamente modular, lo que permitirá en las siguientes fases incorporar bases de datos para historial persistente, agentes de búsqueda de guías clínicas y paneles de control más avanzados.

**