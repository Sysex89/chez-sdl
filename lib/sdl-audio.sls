;;;; -*- mode: Scheme; -*-

(define-record-type sdl-audio-spec
  (fields freq
	  format
	  channels
	  silence
	  samples
	  size
	  callback
	  userdata))

;; SDL_BuildAudioCVT - won't support
;; SDL_ConvertAudio  - won't support

(define sdl-new-audio-stream SDL_NewAudioStream)

(define (sdl-audio-stream-put stream buffer)
  (SDL_AudioStreamPut stream buffer (bytevector-length buffer)))

(define (sdl-audio-stream-get stream buffer)
  (SDL_AudioStreamGet stream buffer (bytevector-length buffer)))

(define sdl-audio-stream-available SDL_AudioStreamAvailable)

(define sdl-audio-stream-flush SDL_AudioStreamFlush)
(define sdl-audio-stream-clear SDL_AudioStreamClear)
(define sdl-free-audio-stream  SDL_FreeAudioStream)


(define (sdl-audio-init driver_name) 
        (SDL_AudioInit driver_name))

(define sdl-audio-quit SDL_AudioQuit)

(define sdl-clear-queued-audio SDL_ClearQueuedAudio)

(define (sdl-get-queued-audio-size sdl-audio-device-ID )
  	(SDL_GetQueuedAudioSize sdl-audio-device-ID ))

(define sdl-close-audio SDL_CloseAudio)

(define sdl-close-audio-device SDL_CloseAudioDevice)

(define (sdl-pause-audio pause_on )(SDL_PauseAudio pause_on  )) ; set pause_on to non-zero to pause, 0 to unpause

(define (sdl-pause-audio-device sdl-audio-device-ID pause_on)
  	(SDL_PauseAudioDevice sdl-audio-device-ID pause_on ))


(define (sdl-get-num-audio-devices iscapture) ;iscapture zero to request playback devices, non-zero to request recording devices
  	(SDL_GetNumAudioDevices iscapture))

(define sdl-get-current-audio-driver SDL_GetCurrentAudioDriver)

(define (sdl-get-audio-device-name index iscapture)
  	(SDL_GetAudioDeviceName index iscapture ))

(define (sdl-get-audio-device-status int )(SDL_GetAudioDeviceStatus int  ))
(define (sdl-get-audio-driver int )(SDL_GetAudioDriver int ))
(define (sdl-get-audio-status)(SDL_GetAudioStatus ))




(define (sdl-audio-spec->ftype audio_spec)
    (let*   ((size (ftype-sizeof SDL_AudioSpec))
            (addr (foreign-alloc size))
            (fptr (make-ftype-pointer SDL_AudioSpec addr)))
            (ftype-set! SDL_AudioSpec (freq) fptr (sdl-audio-spec-freq) audio_spec)
            (ftype-set! SDL_AudioSpec (format) fptr (sdl-audio-spec-format) audio_spec)
            (ftype-set! SDL_AudioSpec (channels) fptr (sdl-audio-spec-channels) audio_spec)
            (ftype-set! SDL_AudioSpec (silence) fptr (sdl-audio-spec-silence) audio_spec)
            (ftype-set! SDL_AudioSpec (samples) fptr (sdl-audio-spec-samples) audio_spec)
            (ftype-set! SDL_AudioSpec (size) fptr (sdl-audio-spec-size) audio_spec)
            (ftype-set! SDL_AudioSpec (callback) fptr (sdl-audio-spec-callback) audio_spec)
            (ftype-set! SDL_AudioSpec (userdata) fptr (sdl-audio-spec-userdata) audio_spec)
            fptr))

