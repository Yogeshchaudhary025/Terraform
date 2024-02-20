module "app_storage" {
    source = "./modules/storage"
    rg_name = local.rg_name
    location = local.location
    storage-account-name = "webstorage001155"
    container-name = "images"
    container-access = "blob"
    storage-account-already-exist = true
    blobs-binary-enabled = true
    blobs-binary={
        "cotton.jpg"="./images/"
        "dark.jpg"="./images/"
        "rock.jpg"="./images/"
        "fortune.jpg"="./images/"
    }
    depends_on = [ module.general ]
}
