module App
include("whisper.jl")
using .WhisperGenie
using GenieFramework
@genietools

@app begin
    @in process = false
    @in url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    @out transcription = ""
    @in transcribe = false
    @in download = false
    @out transcribing = false
    @out downloading = false
    @onchange transcribe begin
        @info "Transcribing $url"
        transcribing = true
        transcription = WhisperGenie.whisper_transcribe()
        transcribing = false
    end
    @onchange download begin
        @info "Downloading $url"
        downloading = true
        WhisperGenie.download_audio(url)
        downloading = false
    end
end

@page("/", "app.jl.html")
end
