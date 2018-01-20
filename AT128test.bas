$regfile = "m128def.dat"
'$sim
$crystal = 16000000



Config Lcdpin = Pin , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2 , E = Porta.4 , Rs = Porta.3
Config Lcd = 16 * 2
Config Portc = Output
Config Portg.0 = Output
Config Portg.1 = Output
Config Portg.3 = Output
Config Portg.4 = Output
Config Portd = Output
Config Portb = Output
Cls

Lcd "ATMega RT Debug"
Lowerline
Wait 1
Lcd "Relay test (2/3)"
Do

Set Portc.3
Set Portc.2
Set Portc.1
Set Portc.0
Set Portg.1
Set Portg.0
Set Portd.7
Set Portd.6
Set Portd.5
Set Portd.4
Set Portg.4
Set Portg.3
Set Portb.0
Set Portb.1
'one used by at8



Loop