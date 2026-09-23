Last login: Sun Sep 20 15:43:03 on ttys000
✨ Hola de nuevo, Ardon. Terminal lista — Sunday, 20 Sep 2026 | 15:52
ardon @ ~ % lenovo-contr
zsh: command not found: lenovo-contr
ardon @ ~ % lenovo-tab
zsh: command not found: lenovo-tab
ardon @ ~ % lenovo-control
zsh: command not found: lenovo-control
ardon @ ~ % vim ~/.zshrc                               
ardon @ ~ % vim ~/.zshrc














 71 }
 72 
 73 diario() {
 74     mkdir -p "$NOTAS_DIR"
 75     if [ -z "$*" ]; then
 76         echo "⚠️  Uso: diario \"Tu entrada aquí\""
 77         return 1
 78     fi
 79     echo "📅 $(date '+%Y-%m-%d %H:%M') | $*" >> "$NOTAS_DIR/diario.md"
 80     echo "✅ Guardado en diario.md"
 81 }
 82 
 83 # Abrir toda la carpeta de notas en Zed
 84 alias cerebro='zed ~/Notas_Cerebro'
 85 
 86 alias organizar="$HOME/Notas_Cerebro/organizar_cerebro_ultra.sh"
 87 
 88 # ══════════════════════════════════════════════════════════════
 89 # BLOQUE 5 — PERSONALIZACIÓN VISUAL
 90 # ══════════════════════════════════════════════════════════════
 91 export CLICOLOR=1
 92 export LSCOLORS=Gxfxcxdxbxegedabagacad
 93 alias ls='ls -G'
                                                              93,1          36%

