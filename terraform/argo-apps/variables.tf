variable "DO_TOKEN" {
  type        = string
  default     = ""
}

variable "SYC_GITHUB_TOKEN" {
  type        = string
  default     = ""
}

variable "FOS_GITHUB_TOKEN" {
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

variable "PROD_POSTMARK_API_TOKEN" {
  type = string
  default = ""
}


variable "EMAIL_WEBHOOK_PASSWORD" {
  type = string
  default = "" 
}


variable "PROD_EMAIL_WEBHOOK_PASSWORD" {
  type = string
  default = "" 
}

variable "OPENAI_API_KEY" {
  type = string
  default = ""
}




variable "PROD_STRIPE_TOKEN" {
  type        = string
  default     = ""
}

variable "PROD_STRIPE_SUBSCRIPTION_PRICE_ID" {
  type        = string
  default     = ""
}

variable "PROD_STRIPE_WEBHOOK_SECRET" {
  type = string
  default = ""
}

variable "PROD_STRIPE_TOPUP_PRICE_ID" {
  type = string
  default = ""  
}
