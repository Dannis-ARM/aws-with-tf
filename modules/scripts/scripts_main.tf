data "external" "myipaddr" {
  program = ["powershell", "-Command", "$ip = Invoke-RestMethod -Uri 'https://ifconfig.me/ip'; $result = @{ip = $ip}; $result | ConvertTo-Json"]
}

output "my_public_ip" {
  value = data.external.myipaddr.result.ip
}
