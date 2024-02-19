variable "DO_TOKEN" {
  type        = string
  default     = ""
}

variable "GITHUB_TOKEN" {
  type        = string
  default     = ""
}

variable "STRIPE_TOKEN" {
  type        = string
  default     = ""
}

variable "STRIPE_SUBSCRIPTION_PRICE_ID" {
  type        = string
  default     = ""
}

variable "STRIPE_WEBHOOK_SECRET" {
  type = string
  default = ""
}

variable "STRIPE_TOPUP_PRICE_ID" {
  type = string
  default = ""  
}

variable "POSTMARK_API_TOKEN" {
  type = string
  default = ""
}

variable "EMAIL_WEBHOOK_PASSWORD" {
  type = string
  default = "" 
}

variable "OPENAI_API_KEY" {
  type = string
  default = ""
}