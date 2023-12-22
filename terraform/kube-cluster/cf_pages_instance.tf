data "cloudflare_accounts" "accounts" {
}

resource "cloudflare_pages_project" "fos_pages_project" {
  account_id        = data.cloudflare_accounts.accounts.accounts[0].id
  name              = "fos-pages-0"
  production_branch = "main"


  build_config {
    build_command   = "make build"
    destination_dir = "build"
    root_dir        = ""
  }

  deployment_configs {
    preview {
      environment_variables = {
        API_URL = "https://fosforescent.com"
        NODE_VERSION = "18.17.1"
        NODE_ENV = "production"
      }
      fail_open = true
    }
    production {
      environment_variables = {
        API_URL = "https://fosforescent.com"
        NODE_VERSION = "18.17.1"
        NODE_ENV = "production"
      }
      fail_open = true
    }
  }
}

resource "cloudflare_pages_domain" "fos_pages_domain" {
  account_id   = cloudflare_pages_project.fos_pages_project.account_id
  project_name = "fos-pages-0"
  domain       = "app.fosforescent.com"
}