$regfile = "m8def.dat"
'$sim
$crystal = 16000000
$baud = 19200

Config Com1 = 19200 , Synchrone = 0 , Parity = None , Stopbits = 1 , Databits = 8 , Clockpol = 0
Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2

'LSB defined as static for num<128
'MSB defined as rule for num>=128
Dim Lsb As Byte
Dim Msb As Byte
Dim X As Integer , A As Integer , B As Integer
Lsb = 0
Msb = 0
Dim Num As Integer
Num = 0
Print 0
Do

     Num = Num + 100
     If Num < 128 Then
      Msb = Num
      'Lsb.7 = 0
      'Print N2
     Elseif Num >= 128 Then
      A = Num / 256
      Msb = A
      X = Msb * 256


      B = Num - X
      Lsb = B

      'Print Num ; Spc(2) ; Msb ; Spc(2) ; Lsb

     End If


     If Num >= 128 Then
      Msb.7 = 0
        Cls
      Lcd Msb
      Msb.7 = 1
      Print Msb

      Waitms 50
      Print Lsb
      Lcd " "
      Lcd Lsb
      Lowerline
      Lcd "Tx:"
      Lcd Num

     Else
      Msb.7 = 0
      cls
      Lcd Msb
      Lowerline
      Lcd Num
      Print Msb
     End If
     Waitms 200


Loop