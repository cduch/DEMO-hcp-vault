
provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

data "terraform_remote_state" "hvn" {
  backend = "remote"

  config = {
    organization = var.organization
    workspaces = {
      name = var.hvnworkspace
    }
  }
}


resource "hcp_vault_cluster" "vault" {
  cluster_id      = "demo-vault"
  hvn_id          = data.terraform_remote_state.hvn.outputs.hvn_id
  tier            = "dev"
  public_endpoint = true
}


output "vault_public_endpoint" {
  value = "${hcp_vault_cluster.vault.vault_public_endpoint_url}"
}