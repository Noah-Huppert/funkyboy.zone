# Lab Log
Records of how different collocation resources were setup.

# Table Of Contents
- [Network](#network)
- [Compute](#compute)

# Network
Components:

- [`SwitchA`](#switcha) ([Cisco Catalyst 3650 24PS L](https://www.cisco.com/c/en/us/support/switches/catalyst-3650-series-switches/series.html))

Subnets:

| Name  | VLAN | CIDR          |
|-------|------|---------------|
| mgmt0 | 100  | 10.10.10.1/24 |

Reserved for future use: 10.0.0.0/24 to 10.9.0.0/24. In each subnet the addresses X.X.X.0 to X.X.X.10 (inclusive) are also reserved for future use (.0 and .255 are of course also reserved).

Static IP allocations should start from X.X.X.254 and count down.

Devices:

| Name         | Interface              | IP           |
|--------------|------------------------|--------------|
| NodeA - IPMI | GigabitEthernet 1/0/11 | 10.10.10.254 |

## SwitchA
### Connecting
1. Plug in to the USB Mini terminal port to the switch and another computer
2. Open a serial terminal:
   ```
   screen /dev/ttyACM* 9600
   ```

### Configure
At the end of any session making changes save modifications:

```cisco
# enable
write memory
copy running-config usbflash0:startup-config-YYYY-MM-DD-HH-TT
```

Configuration:

- ```cisco
  # configure terminal#
  no ip domain-lookup
  ```
   Stop DNS lookup on wrong command
- Hostname
  ```cisco
  # configure terminal
  hostname SwitchA
  ```
- Ensure boot and configuration reading are setup correctly:
  - Ensure startup-config is used
    ```cisco
    # configure terminal
    no system ignore startupconfig switch all
    boot system flash:cat3k_caa-universalk9.16.12.11.SPA.bin
    ```
    If the OS image is not in flash (Check with `dir flash:`) then"
    - [Download the image from the Cisco site](https://software.cisco.com/download/home/284846017/type/282046477/release/Gibraltar-16.12.11)
    - Put the image on a flash drive
    - Plug the flash drive into the switch's USB A port
    - Copy the image from the flash drive to the flash storage:
      ```cisco
      copy usbflash0:<IMAGE NAME> flash:<IMAGE NAME>
      ```
      Then follow the steps to set the image as the default
  - Ensure the config-register is set to `0x102`, run `show version` and the value will be at the way bottom ([Cisco Docs](https://www.cisco.com/c/en/us/support/docs/routers/10000-series-routers/50421-config-register-use.html))
- Establish layer 3 connectivity to the external internet
  - Setup name servers (Cloudflare)
    ```
    # configure terminal
    ip name-server 1.1.1.1 1.0.0.1
    ```
  - Set switch's domain name (Used when generating TLS certificates and such)
    ```
    # configure terminal
    ip domain name funkyboy.zone
    ```
  - 
- Enable layer 3 routing
  ```cisco
  # configure terminal
  ip routing
  ```
- Management VLAN
  - Create VLAN
    - Management
      ```cisco
      # configure terminal
      vlan 100
      name mgmt0
      ```
    - Public traffic
      ```cisco
      # configure terminal
      vlan 200
      name public0
      ```
  - Attach interfaces
    - Management
      ```cisco
      # configure terminal
      interface range gigabitEthernet 1/0/3-12
      switchport mode access
      switchport access vlan name mgmt0
      ```
    - Public traffic
      ```cisco
      # configure terminal
      interface range gigabitEthernet 1/0/13-24
      switchport mode access
      switchport access vlan name public0
      ```
  - Configure IPs
    - Management
      - Switch
        ```cisco
        # configure terminal
        interface vlan 100
        ip add 10.10.10.1 255.255.255.0
        ```
      - DHCP pool
        ```cisco
        # configure terminal
        ip dhcp excluded-address 10.10.10.1 10.10.10.10
        
        ip dhcp pool mgmt0
        network 10.10.10.0 255.255.255.0
        default-router 10.10.10.1
        dns-server 8.8.8.8
        ```
        ```cisco
        service dhcp mgmt0
        ```
      - NodeA IPMI static IP
        ```cisco
        # configure terminal
        ip dhcp pool mgmt0-static
        host 10.10.10.254 255.255.255.0
        client-identifier 0100.2590.d75f.94
        ```
    - Public traffic
      - Switch
        ```cisco
        # configure terminal
        interface vlan 200
        ip add 10.10.20.1 255.255.255.0
        ```
      - DHCP pool
        ```cisco
        # configure terminal
        ip dhcp excluded-address 10.10.20.1 10.10.20.10
        
        ip dhcp pool public0
        network 10.10.20.0 255.255.255.0
        default-router 10.10.20.1
        dns-server 8.8.8.8
        ```
      - NodeA static IP
        ```cisco
        # configure terminal
        ip dhcp pool public0-static
        host 10.10.20.254 255.255.255.0
        client-identifier 0100.2590.d761.16
        ```
    
# Compute
Components:

- [NodeA](#nodea)

## NodeA
### Connecting
Connect the IPMI ethernet port to the switch. Ensure the switch is running a DHCP server so the node gets an IP.

Then connect your laptop to the same VLAN on the switch and navigate to the IPMI port's IP in your browser. 

The default login is:

| Username | Password |
|----------|----------|
| `ADMIN`  | `ADMIN`  |

### Configuration

- Activate license for IPMI
  - In the IPMI web console go to: Maintenance > BIOS Update
  - Enter the product key
