$regfile = "m8def.dat"
'$sim
$crystal = 16000000
$baud = 19200

Config Com1 = 19200 , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2

'Declare Sub Sendmonobyte()
Dim Num As integer
Num = 0
Print 0
Do

     'Num = 0
     Print Num
     'print 0
     Cls
     Lcd Num
     Num = Num + 1
     Waitms 10
Loop