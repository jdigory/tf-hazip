variable "fastly_api_key" {
  type = "string"
}

variable "domain" {
  type = "string"
}

provider "fastly" {
  api_key = "${var.fastly_api_key}"
}

resource "fastly_service_v1" "hazip" {
  name = "hazip"

  domain {
    name = "${var.domain}"
  }

  vcl {
    name    = "main"
    main    = "true"
    content = "${file("synth.vcl")}"
  }
}
