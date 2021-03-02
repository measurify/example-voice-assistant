# Progetto e realizzazione di assistente vocale
Ho realizzato un assistente vocale che mostra i comandi vocali registrati all'interno di una applicazione Android.
L'assistente (implementato su raspberry pi), puo' anche ottenere i comandi vocali precedentemente registrati.

# Quick start
## Edge
Il codice del'assistente e' scritto in python, una volta avviato mostra una interfaccia console.
Per avviare lo script, e' necessario che python sia installato sul pc e che al pc sia collegato un microfono.
Dopo aver salvato lo script in una directory a piacere, nel Prompt dei comandi o nel Terminal (il funzionamento e' lo stesso su tutti i Sistemi Operativi), digitare il comando:

- *python VoiceAssistant.py*
oppure
- *python3 VoiceAssistant.py*
(dipende dall'installazione di python).

## Client
La app e' stata realizzata in Flutter e testata con Android Emulator.
### Softwares and Framework
- Android Studio [https://developer.android.com/studio](https://link.com)
- Flutter [https://flutter.dev/docs/get-started/install](https://link.com)
- Visual Studio Code (opzionale)  [https://code.visualstudio.com/download](https://link.com)

In Android Studio, nella barra degli Strumenti, selezionere un Virtual Device dalla lista andando su *Tools -> AVD Manager*.
Una volta selezionato l'emulatore, cliccando su *Run*, l'ambiente di sviluppo lancera' la Applicazione sull'emulatore selezionato.