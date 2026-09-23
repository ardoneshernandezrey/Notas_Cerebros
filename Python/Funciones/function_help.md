Last login: Thu Jul  2 06:29:30 on ttys000
✨ Hola de nuevo, Ardon. Terminal lista — Thursday, 02 Jul 2026 | 09:27
ardon @ ~ % python
Python 3.13.11 | packaged by Anaconda, Inc. | (main, Dec 10 2025, 21:21:08) [Clang 20.1.8 ] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> help
Welcome to Python 3.13's help utility! If this is your first time using
Python, you should definitely check out the tutorial at
https://docs.python.org/3.13/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To get a list of available
modules, keywords, symbols, or topics, enter "modules", "keywords",
"symbols", or "topics".

Each module also comes with a one-line summary of what it does; to list
the modules whose name or summary contain a given string such as "spam",
enter "modules spam".

To quit this help utility and return to the interpreter,
enter "q", "quit" or "exit".

help> function
No Python documentation found for 'function'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> function()
No Python documentation found for 'function()'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> (function)
No Python documentation found for '(function)'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> 1
No Python documentation found for '1'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> "function"
No Python documentation found for 'function'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> 

You are now leaving help and returning to the Python interpreter.
If you want to ask for help on a particular object directly from the
interpreter, you can type "help(object)".  Executing "help('string')"
has the same effect as typing a particular string at the help> prompt.
>>> modules
Traceback (most recent call last):
  File "<python-input-0>", line 1, in <module>
    modules
NameError: name 'modules' is not defined
>>> help(modules)
Traceback (most recent call last):
  File "<python-input-1>", line 1, in <module>
    help(modules)
         ^^^^^^^
NameError: name 'modules' is not defined
>>> help
Welcome to Python 3.13's help utility! If this is your first time using
Python, you should definitely check out the tutorial at
https://docs.python.org/3.13/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To get a list of available
modules, keywords, symbols, or topics, enter "modules", "keywords",
"symbols", or "topics".

Each module also comes with a one-line summary of what it does; to list
the modules whose name or summary contain a given string such as "spam",
enter "modules spam".

To quit this help utility and return to the interpreter,
enter "q", "quit" or "exit".

help> modules

Please wait a moment while I gather a list of all available modules...

0.00s - Debugger warning: It seems that frozen modules are being used, which may
0.00s - make the debugger miss breakpoints. Please pass -Xfrozen_modules=off
0.00s - to python to disable frozen modules.
0.00s - Note: Debugging will proceed. Set PYDEVD_DISABLE_FILE_VALIDATION=1 to disable this validation.
/opt/miniconda3/lib/python3.13/pkgutil.py:78: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  __import__(info.name)
IPython             bert_test_data      imaplib             pycparser
OleFileIO_PL        binascii            import_utils        pydantic
PIL                 bisect              importlib           pydantic_core
__future__          bleach              importlib_metadata  pydantic_settings
__hello__           boltons             inflect             pydoc
__phello__          brotlicffi          inspect             pydoc_data
_abc                bs4                 io                  pydub
_aix_support        builtins            io_binding_helper   pyexpat
_android_support    bz2                 ipaddress           pygments
_apple_support      cProfile            ipykernel           pypdfium2
_argon2_cffi_bindings calcu_tem2          ipykernel_launcher  pypdfium2_cfg
_ast                calcul_tem          ipython_pygments_lexers pypdfium2_cli
_asyncio            calendar            isodate             pypdfium2_raw
_bisect             certifi             isoduration         pythonjsonlogger
_blake2             cffi                itertools           quantize_helper
_bz2                charset_normalizer  jedi                queue
_cffi_backend       chunk               jinja2              quopri
_codecs             click               jrnl                random
_codecs_cn          cmath               json                re
_codecs_hk          cmd                 json5               readchar
_codecs_iso2022     cobble              jsonpatch           readline
_codecs_jp          code                jsonpointer         referencing
_codecs_kr          codecs              jsonschema          reprlib
_codecs_tw          codeop              jsonschema_specifications requests
_collections        collections         jupyter             resource
_collections_abc    colorama            jupyter_client      rfc3339_validator
_colorize           colorsys            jupyter_core        rfc3986_validator
_compat_pickle      comm                jupyter_events      rfc3987_syntax
_compression        compare_bert_results jupyter_lsp         rich
_contextvars        compileall          jupyter_server      rlcompleter
_csv                concurrent          jupyter_server_terminals rpds
_ctypes             conda               jupyterlab          runpy
_ctypes_test        conda_anaconda_telemetry jupyterlab_pygments sched
_curses             conda_anaconda_tos  jupyterlab_server   secrets
_curses_panel       conda_content_trust jwt                 select
_datetime           conda_env           keyring             selectors
_dbm                conda_libmamba_solver keyword             semver
_decimal            conda_package_handling large_model_exporter send2trash
_distutils_hack     conda_package_streaming lark                setuptools
_elementtree        configparser        libmambapy          shape_infer_helper
_functools          constants           linecache           shape_optimizer
_hashlib            contextlib          lista_pacientes     shellingham
_heapq              contextvars         locale              shelve
_imp                convert_generation  locutor             shlex
_interpchannels     convert_tf_models_to_pytorch logging             shutil
_interpqueues       convert_to_packing_mode lxml                signal
_interpreters       copy                lzma                site
_io                 copyreg             machine_info        sitecustomize
_ios_support        cryptography        magika              six
_json               csv                 mailbox             smtplib
_locale             ctypes              mammoth             socket
_lsprof             curses              markdown_it         socketserver
_lzma               dataclasses         markdownify         socks
_markupbase         datetime            markitdown          sockshandler
_md5                dateutil            markupsafe          soupsieve
_multibytecodec     dbm                 marshal             speech_recognition
_multiprocessing    debugpy             math                sqlite3
_opcode             decimal             matplotlib_inline   sre_compile
_opcode_metadata    decorator           mdurl               sre_constants
_operator           defusedxml          menuinst            sre_parse
_osx_support        desempaquetat       metrics             ssl
_pickle             difflib             mimetypes           stack_data
_posixshmem         dis                 mistune             stat
_posixsubprocess    distro              mmap                statistics
_py_abc             doctest             modulefinder        string
_pydatetime         dotenv              more_itertools      stringprep
_pydecimal          dynamo_onnx_helper  msal                struct
_pyio               ejercici_3          msal_extensions     subprocess
_pylong             email               msgpack             symtable
_pyrepl             encodings           multiprocessing     sys
_queue              ensurepip           nbclient            sysconfig
_random             enum                nbconvert           syslog
_ruamel_yaml        errno               nbformat            tabnanny
_scproxy            et_xmlfile          nest_asyncio        tarfile
_sha1               executing           netrc               tempfile
_sha2               fahrenheit_Centigrados notebook_shim       terminado
_sha3               fahrenheit_a_C      ntpath              termios
_signal             fastjsonschema      nturl2path          test
_sitebuiltins       faulthandler        numbers             test_pycosat
_socket             fcntl               numpy               test_re
_sqlite3            filecmp             olefile             textwrap
_sre                fileinput           onnx_exporter       this
_ssl                flatbuffers         onnx_model          threading
_stat               float16             onnx_model_bart     time
_statistics         fnmatch             onnx_model_bert     timeit
_string             fqdn                onnx_model_bert_keras tinycss2
_strptime           fractions           onnx_model_bert_tf  tkinter
_struct             frozendict          onnx_model_clip     token
_suggestions        ftplib              onnx_model_conformer tokenize
_symtable           functools           onnx_model_gpt2     tomli
_sysconfig          fusion_attention    onnx_model_mmdit    tomllib
_sysconfigdata__darwin_darwin fusion_attention_clip onnx_model_phi      torch_onnx_export_helper
_sysconfigdata_arm64_apple_darwin20_0_0 fusion_attention_sam2 onnx_model_sam2     tornado
_testbuffer         fusion_attention_unet onnx_model_t5       tqdm
_testcapi           fusion_attention_vae onnx_model_tnlr     trace
_testclinic         fusion_bart_attention onnx_model_unet     traceback
_testclinic_limited fusion_base         onnx_model_vae      tracemalloc
_testexternalinspection fusion_bias_add     onnx_utils          traitlets
_testimportmultiple fusion_biasgelu     onnxruntime         truststore
_testinternalcapi   fusion_biassplitgelu opcode              tty
_testlimitedcapi    fusion_conformer_attention openpyxl            turtle
_testmultiphase     fusion_constant_fold operator            turtledemo
_testsinglephase    fusion_embedlayer   operator_type_usage_processors typeguard
_thread             fusion_fastgelu     optimizer           typer
_threading_local    fusion_gelu         optparse            types
_tkinter            fusion_gelu_approximation ort_flatbuffers_py  typing
_tokenize           fusion_gemmfastgelu ort_model_processor typing_extensions
_tracemalloc        fusion_gpt_attention os                  typing_inspection
_typing             fusion_gpt_attention_megatron packaging           tzdata
_uuid               fusion_gpt_attention_no_past pandas              tzlocal
_warnings           fusion_group_norm   pandocfilters       unicodedata
_weakref            fusion_layernorm    parsedatetime       unittest
_weakrefset         fusion_mha_mmdit    parso               uri_template
_xxtestfuzz         fusion_nhwc_conv    past_helper         urllib
_yaml               fusion_options      pathlib             urllib3
_zoneinfo           fusion_qordered_attention pdb                 utils
abc                 fusion_qordered_gelu pdfminer            uuid
affinity_helper     fusion_qordered_layernorm pdfplumber          venv
aifc                fusion_qordered_matmul pexpect             verbs_speaker
anaconda_anon_usage fusion_quickgelu    pickle              warnings
anaconda_auth       fusion_reshape      pickletools         wave
anaconda_cli_base   fusion_rotary_attention pip                 wcwidth
anaconda_cloud_auth fusion_shape        pkce                weakref
annotated_types     fusion_simplified_layernorm pkg_resources       webbrowser
antigravity         fusion_skip_group_norm pkgutil             webcolors
anyio               fusion_skiplayernorm platform            webencodings
appnope             fusion_transpose    platformdirs        websocket
archspec            fusion_utils        plistlib            wheel
argon2              gc                  pluggy              wsgiref
argparse            genericpath         poplib              xdg
array               getopt              posix               xlrd
arrow               getpass             posixpath           xlsxwriter
ast                 gettext             pprint              xml
asttokens           glob                pptx                xmlrpc
async_lru           graphlib            profile             xxlimited
asyncio             grp                 profile_result_processor xxlimited_35
atexit              gzip                profiler            xxsubtype
attr                h11                 prometheus_client   yaml
attrs               hashlib             prompt_toolkit      youtube_transcript_api
audioop             heapq               pstats              zipapp
autocommand         hmac                psutil              zipfile
babel               html                pty                 zipimport
backports           http                ptyprocess          zipp
base64              httpcore            pure_eval           zlib
bdb                 httpx               pwd                 zmq
benchmark           huggingface_models  py_compile          zoneinfo
benchmark_helper    idlelib             pyclbr              zstandard
bert_perf_test      idna                pycosat             

Enter any module name to get more help.  Or, type "modules spam" to search
for modules whose name or summary contain the string "spam".

help> def
zsh:1: command not found: If
!done  (press RETURN)

help> uit" or "exit".
No Python documentation found for 'uit" or "exit".'.
Use help() to get the interactive help utility.
Use help(str) for help on the str class.

help> 

You are now leaving help and returning to the Python interpreter.
If you want to ask for help on a particular object directly from the
interpreter, you can type "help(object)".  Executing "help('string')"
has the same effect as typing a particular string at the help> prompt.
>>> help> function
Traceback (most recent call last):
  File "<python-input-2>", line 1, in <module>
    help> function
          ^^^^^^^^
NameError: name 'function' is not defined
>>> No Python documentation found for 'function'.
  File "<python-input-3>", line 1
    No Python documentation found for 'function'.
       ^^^^^^
SyntaxError: invalid syntax
>>> Use help() to get the interactive help utility.
  File "<python-input-4>", line 1
    Use help() to get the interactive help utility.
        ^^^^
SyntaxError: invalid syntax
>>> Use help(str) for help on the str class.
  File "<python-input-5>", line 1
    Use help(str) for help on the str class.
        ^^^^
SyntaxError: invalid syntax
>>> 
>>> help> function()
Traceback (most recent call last):
  File "<python-input-7>", line 1, in <module>
    help> function()
          ^^^^^^^^
NameError: name 'function' is not defined
>>> No Python documentation found for 'function()'.
  File "<python-input-8>", line 1
    No Python documentation found for 'function()'.
       ^^^^^^
SyntaxError: invalid syntax
>>> Use help() to get the interactive help utility.
  File "<python-input-9>", line 1
    Use help() to get the interactive help utility.
        ^^^^
SyntaxError: invalid syntax
>>> Use help(str) for help on the str class.
  File "<python-input-10>", line 1
    Use help(str) for help on the str class.
        ^^^^
SyntaxError: invalid syntax
>>> 
>>> help> (function)
Traceback (most recent call last):
  File "<python-input-12>", line 1, in <module>
    help> (function)
           ^^^^^^^^
NameError: name 'function' is not defined
>>> No Python documentation found for '(function)'.
  File "<python-input-13>", line 1
    No Python documentation found for '(function)'.
       ^^^^^^
SyntaxError: invalid syntax
>>> Use help() to get the interactive help utility.
  File "<python-input-14>", line 1
    Use help() to get the interactive help utility.
        ^^^^
SyntaxError: invalid syntax
>>> Use help(str) for help on the str class.
  File "<python-input-15>", line 1
    Use help(str) for help on the str class.
        ^^^^
SyntaxError: invalid syntax
>>> 
>>> help> 1
Traceback (most recent call last):
  File "<python-input-17>", line 1, in <module>
    help> 1
TypeError: '>' not supported between instances of '_Helper' and 'int'
>>> No Python documentation found for '1'.
  File "<python-input-18>", line 1
    No Python documentation found for '1'.
       ^^^^^^
SyntaxError: invalid syntax
>>> Use help() to get the interactive help utility.
  File "<python-input-19>", line 1
    Use help() to get the interactive help utility.
        ^^^^
SyntaxError: invalid syntax
>>> Use help(str) for help on the str class.
  File "<python-input-20>", line 1
    Use help(str) for help on the str class.
        ^^^^
SyntaxError: invalid syntax
>>> 
>>> help> "function"
Traceback (most recent call last):
  File "<python-input-22>", line 1, in <module>
    help> "function"
TypeError: '>' not supported between instances of '_Helper' and 'str'
>>> No Python documentation found for 'function'.
  File "<python-input-23>", line 1
    No Python documentation found for 'function'.
       ^^^^^^
SyntaxError: invalid syntax
>>> Use help() to get the interactive help utility.
  File "<python-input-24>", line 1
    Use help() to get the interactive help utility.
        ^^^^
SyntaxError: invalid syntax
>>> Use help(str) for help on the str class.
  File "<python-input-25>", line 1
    Use help(str) for help on the str class.
        ^^^^
SyntaxError: invalid syntax
>>> 
>>> help
Welcome to Python 3.13's help utility! If this is your first time using
Python, you should definitely check out the tutorial at
https://docs.python.org/3.13/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To get a list of available
modules, keywords, symbols, or topics, enter "modules", "keywords",
"symbols", or "topics".

Each module also comes with a one-line summary of what it does; to list
the modules whose name or summary contain a given string such as "spam",
enter "modules spam".

To quit this help utility and return to the interpreter,
enter "q", "quit" or "exit".

help> def

Function definitions
********************

A function definition defines a user-defined function object (see
section The standard type hierarchy):

   funcdef                   ::= [decorators] "def" funcname [type_params] "(" [
parameter_list] ")"
                                 ["->" expression] ":" suite
   decorators                ::= decorator+
   decorator                 ::= "@" assignment_expression NEWLINE
   parameter_list            ::= defparameter ("," defparameter)* "," "/" ["," [
parameter_list_no_posonly]]
                                 | parameter_list_no_posonly
   parameter_list_no_posonly ::= defparameter ("," defparameter)* ["," [paramete
r_list_starargs]]
                                 | parameter_list_starargs
   parameter_list_starargs   ::= "*" [star_parameter] ("," defparameter)* ["," [
parameter_star_kwargs]]
                                 | "*" ("," defparameter)+ ["," [parameter_star_
kwargs]]
                                 | parameter_star_kwargs
   parameter_star_kwargs     ::= "**" parameter [","]
   parameter                 ::= identifier [":" expression]
   star_parameter            ::= identifier [":" ["*"] expression]
   defparameter              ::= parameter ["=" expression]
   funcname                  ::= identifier

A function definition is an executable statement.  Its execution binds
the function name in the current local namespace to a function object
(a wrapper around the executable code for the function).  This
function object contains a reference to the current global namespace
as the global namespace to be used when the function is called.

The function definition does not execute the function body; this gets
executed only when the function is called. [4]

A function definition may be wrapped by one or more *decorator*
expressions. Decorator expressions are evaluated when the function is
defined, in the scope that contains the function definition.  The
result must be a callable, which is invoked with the function object
as the only argument. The returned value is bound to the function name
instead of the function object.  Multiple decorators are applied in
nested fashion. For example, the following code

   @f1(arg)
   @f2
   def func(): pass

is roughly equivalent to

 Help on def line 1/159 28% (press h for help or q to quit)

