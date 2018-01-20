$regfile = "m88def.dat"
$crystal = 12000000

Config Portb = Output
Config Portd = Output
Dim T As Integer
T = 2000
Do

Set Portb.2
Set Portb.0
Set Portd.6
Reset Portb.1
Reset Portd.7
Reset Portd.5
Waitms T

Set Portb.1
Set Portd.7
Set Portd.5
Reset Portb.0
Reset Portb.2
Reset Portd.6
Waitms T




Loop