module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "4.0.3"

  home_region = var.chango_regions["home"]
  region      = var.chango_regions["chango"]

  tenancy_id = var.tenancy_id

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = "dev"

  # ssh keys
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path

  # networking
  create_drg                   = true
  internet_gateway_route_rules = []
  nat_gateway_route_rules      = []

  vcn_cidrs     = ["10.0.0.0/16"]
  vcn_dns_label = "chango"
  vcn_name      = "chango"

  # bastion host
  create_bastion_host = false
  upgrade_bastion     = false

  # operator host
  create_operator                    = false
  enable_operator_instance_principal = false
  upgrade_operator                   = false

  # oke cluster options
  cluster_name                = "chango"
  control_plane_type          = "private"
  control_plane_allowed_cidrs = ["0.0.0.0/0"]
  kubernetes_version          = "v1.21.5"
  pods_cidr                   = "10.244.0.0/16"
  services_cidr               = "10.96.0.0/16"

  # node pools
  node_pools = {
    np1 = { shape = "VM.Standard.E4.Flex", ocpus = 2, memory = 32, node_pool_size = 2, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
  }
  node_pool_name_prefix = "chango"

  # oke load balancers
  load_balancers          = "both"
  preferred_load_balancer = "public"
  public_lb_allowed_cidrs = ["0.0.0.0/0"]
  public_lb_allowed_ports = [80, 443]

  # freeform_tags
  freeform_tags = var.freeform_tags["oke"]

  providers = {
    oci.home = oci.home
  }
}
