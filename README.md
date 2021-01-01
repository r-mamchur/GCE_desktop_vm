# GCP. Instance with GUI.

Terraform v0.14.3   
It is based on CentOS 7.   
Connect with RDP or VNC.   
IP address is reserved.

Installed:
```
mc          wget                unzip           git        
yum-utils   nano                jq              tree       
sshfs       davfs2              sos             cockpit    
Ansible     Terraform           rakyll/hey
Docker      Docker-composer     kubectl         Helm
Istioctl    
```
***root*** SSH connect as  is allowed.   
Configuration of infrastrukture in `variables.tf`.   
Users/Passwords is configured in `conf_vars.yml`, the number is variable.   

#### RDP
Simply.

#### VNC
Network is untrusted. So, connect through secure tunnel.    
`ssh -v -C -L 5901:localhost:5901 terr@<IP> -i <private_key_path>`   
or Putty   
***note:***    
    `"PasswordAuthentication no" in  sshd_config. `   
    change it for auth. with  password.   
Run vncserver, for ex.    
`vncserver -depth 16 -geometry 1200x900 :1 -localhost `   
"-localhost" - VNC clients connect only through a secure tunnel.   
First run, password need to be set.    

Another way, run as service.   
Look at `/usr/lib/systemd/system/vncserver@.service`   

### Running terraform
After `terraform` is installed, `GCP account` is created and `Project` is created too,   
[enable `Compute Engine API` and get service account](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build?in=terraform/gcp-get-started#setting-up-gcp)   
 Next, edit `variables.tf`.   
 And run in directory    
 ```sh
 terrafor init
 terraform apply 

external_static_ip = "34.123.246.18"
```
