variable env {}
variable bucket_out_name {}
variable project_id {}
variable pubsub_id {}
variable region {}
variable transcoder_hls_template_name {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }
  }
}

resource "google_transcoder_job_template" "transcoder_template_hls" {

  project           = var.project_id
  job_template_id   = var.transcoder_hls_template_name
  location          = var.region

  config {
    elementary_streams {
      key = "video-stream0"
      video_stream {
        h264 {
          width_pixels      = 170
          height_pixels     = 96
          bitrate_bps       = 130000
          frame_rate        = 15
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream1"
      video_stream {
        h264 {
          width_pixels      = 256
          height_pixels     = 144
          bitrate_bps       = 240000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream2"
      video_stream {
        h264 {
          width_pixels      = 416
          height_pixels     = 234
          bitrate_bps       = 300000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream3"
      video_stream {
        h264 {
          width_pixels      = 640
          height_pixels     = 360
          bitrate_bps       = 400000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream4"
      video_stream {
        h264 {
          width_pixels      = 768
          height_pixels     = 432
          bitrate_bps       = 1100000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream5"
      video_stream {
        h264 {
          width_pixels      = 960
          height_pixels     = 540
          bitrate_bps       = 2200000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream6"
      video_stream {
        h264 {
          width_pixels      = 1280
          height_pixels     = 720
          bitrate_bps       = 3300000
          frame_rate        = 30
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream7"
      video_stream {
        h264 {
          width_pixels      = 1280
          height_pixels     = 720
          bitrate_bps       = 5500000
          frame_rate        = 60
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream8"
      video_stream {
        h264 {
          width_pixels      = 1920
          height_pixels     = 1080
          bitrate_bps       = 6000000
          frame_rate        = 60
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "video-stream9"
      video_stream {
        h264 {
          width_pixels      = 1920
          height_pixels     = 1080
          bitrate_bps       = 9000000
          frame_rate        = 60
          gop_duration      = "4.0s"
          pixel_format      = "yuv420p"
          rate_control_mode = "crf"
          crf_level         = 10
          profile           = "high"
          preset            = "medium"
        }
      }
    }
    elementary_streams {
      key = "audio-stream0"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 32000
      }
    }
    elementary_streams {
      key = "audio-stream1"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 64000
      }
    }
    elementary_streams {
      key = "audio-stream2"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 96000
      }
    }
    elementary_streams {
      key = "audio-stream3"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 128000
      }
    }
    elementary_streams {
      key = "audio-stream4"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 160000
      }
    }
    elementary_streams {
      key = "audio-stream5"
      audio_stream {
        codec             = "aac"
        bitrate_bps       = 384000
      }
    }
    mux_streams {
      key                = "1"
      container          = "ts"
      elementary_streams = ["video-stream0", "audio-stream0"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "2"
      container          = "ts"
      elementary_streams = ["video-stream0", "audio-stream0"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "3"
      container          = "ts"
      elementary_streams = ["video-stream2", "audio-stream1"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "4"
      container          = "ts"
      elementary_streams = ["video-stream3", "audio-stream1"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "5"
      container          = "ts"
      elementary_streams = ["video-stream4", "audio-stream2"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "6"
      container          = "ts"
      elementary_streams = ["video-stream5", "audio-stream3"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "7"
      container          = "ts"
      elementary_streams = ["video-stream6", "audio-stream3"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "8"
      container          = "ts"
      elementary_streams = ["video-stream7", "audio-stream4"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "9"
      container          = "ts"
      elementary_streams = ["video-stream8", "audio-stream4"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    mux_streams {
      key                = "10"
      container          = "ts"
      elementary_streams = ["video-stream9", "audio-stream5"]
      segment_settings {
         segment_duration   = "4.0s"
      }
    }
    manifests {
      file_name = "manifest.m3u8"
      type      = "HLS"
      mux_streams = ["1, 2, 3, 4, 5, 6, 7, 8, 9, 10"]
    }
    pubsub_destination {
      topic = var.pubsub_id
    }
  }
  labels = {
    "label" = "key"
  }
}