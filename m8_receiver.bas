$regfile = "m8def.dat"
'$sim
$crystal = 16000000
$baud = 57600
Config Com1 = 57600 , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0

Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2




Dim Num As Integer
Dim Lsb As Byte
Dim Msb As Byte
Dim X As Integer

Lcd "Hello"
Wait 1
Cls
Do

      Msb = Waitkey()
      Input Msb
      If Msb.7 = 0 Then
         Num = Msb
         X = 1
      Elseif Msb.7 = 1 Then
         Lsb = Waitkey()
         Input Lsb
         Msb.7 = 0

         Num = Msb * 256
         Num = Lsb + Num
         X = 2
      End If
   Cls
   Lcd "Rx:" ; Num
   Lowerline
   Lcd "Bytes:"
   Lcd X
Loop

