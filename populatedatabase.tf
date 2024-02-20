module "storage" {
    source = "./modules/storage"
    rg_name = local.rg_name
    location = local.location
    storage-account-name = "webstorage001155"
    container-name = "scripts"
    container-access = "blob"
    app-container-name = "images"
    blobs-enabled = true
    blobs={
        "01.sql"="./dbscripts/"
        "Script.ps1"="./scripts/"
    }
    depends_on = [ module.general ]
}

module "custom_script_extension_seed_database" {
    source = "./modules/compute/custom-extensions"
    rg_name = local.rg_name
    location = local.location
    extension-name = "dbvm-extension"
    extension-type = "CustomScriptExtension"
    publisher = "Microsoft.Compute"
    vm-id = module.compute.vm_output.id
    handler-version = "1.10"
    storage_account_name = "scripts"
    container_name = "webstorage001155"
    depends_on = [ module.general,module.compute,module.storage ]
}