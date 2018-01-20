$regfile = "m8def.dat"
'$sim
$crystal = 16000000
$baud = 9600

Config Com1 = 19200 , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2
Dim Num As Byte
Num = 123


Do


Wait 4
Num = Rnd(255)
Print Num
Lcd "Sent "
Lcd Num
Wait 1
Cls

Loop
End                                                         'end program