resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Boss Menu'

version '1.0.1'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}


client_scripts {
  '@es_extended/locale.lua',
  'client/main.lua'
}
