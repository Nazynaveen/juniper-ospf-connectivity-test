# Juniper OSPF Connectivity Test 

This project automates the configuration and verification of **OSPF connectivity** between two **Juniper MX series routers** using the **JT (Juniper Test) framework**.

---

## 📌 Project Purpose

- Automatically configures IP addresses on Juniper router interfaces
- Enables OSPF routing protocol on both devices
- Verifies connectivity by sending ICMP `ping` between routers
- Structured to follow the JT automation framework with `.pl`, `.pm`, and `.params` files

---

## 🛠️ Technologies Used

| Tool / Language | Purpose |
|-----------------|---------|
| **Perl**        | JT automation scripting |
| **JT Framework**| Juniper test execution |
| **Juniper MX**  | Test routers |
| **Expect/Telnet**| Device CLI interaction (via JT) |

---
# Run the script
  ./configure_ping_test.pl -p router_config.params -sr -r 1

---

