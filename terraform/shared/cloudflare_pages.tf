

data "cloudflare_accounts" "accounts" {
}

resource "cloudflare_pages_project" "fos_pages_project" {
  account_id        = data.cloudflare_accounts.accounts.accounts[0].id
  name              = local.cf_pages_name["prod"]
  production_branch = local.cf_pages_branch["prod"]


  build_config {
    build_command   = "make build"
    destination_dir = "build"
    root_dir        = ""
  }

  deployment_configs {
    preview {
      environment_variables = {
        FOS_API_URL = "https://api.${local.fos_domain["dev"]}"
        SYC_API_URL = "https://api.${local.syc_domain["dev"]}"
        NODE_VERSION = "18.17.1"
        NODE_ENV = "production"
      }
      fail_open = true
    }
    production {
      environment_variables = {
        FOS_API_URL = "https://api.${local.fos_domain["prod"]}"
        SYC_API_URL = "https://api.${local.syc_domain["prod"]}"
        NODE_VERSION = "18.17.1"
        NODE_ENV = "production"
      }
      fail_open = true
    }
  }
}

resource "cloudflare_pages_domain" "fos_pages_domain" {
  account_id   = cloudflare_pages_project.fos_pages_project.account_id
  project_name = local.cf_pages_name["prod"]
  domain       = "www.fosforescent.com"
}