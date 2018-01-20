$regfile = "m8def.dat"
$crystal = 16000000
'------------------------
Dim Mulia As Byte , Request As Byte
Mulia = &H01 : Request = &H42
Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2
Dim Terina As Byte
Dim Data1 As Byte , Data2 As Byte
Dim Alog_x_kanan As Byte , Alog_y_kanan As Byte
Dim Alog_x_kiri As Byte , Alog_y_kiri As Byte
'---------------
Miso Alias Portd.7 : Ddrb.7 = 0
Mosi Alias Portb.1 : Ddrb.1 = 1
Ss Alias Portd.6 : Ddrb.6 = 1
Sck Alias Portb.0 : Ddrb.0 = 1
Miso = 1

'---------------
Cls
'Cursor Off
Waitms 50
Do
Gosub Baca_data:
Upperline
Lcd Bin(data1) ; Bin(data2)
Lowerline
Lcd Alog_x_kiri ; "|" ; Alog_y_kiri ; "|" ; Alog_x_kanan ; "|" ; Alog_y_kanan
Loop
'-------------
Baca_data:
  Ss = 0
   Shiftout Mosi , Sck , Mulia , 2 , 8 , 20
   Shiftout Mosi , Sck , Request , 2 , 8 , 20

   Shiftin Miso , Sck , Terina , 2 , 8 , 20

   Shiftin Miso , Sck , Data1 , 2 , 8 , 20
   Shiftin Miso , Sck , Data2 , 2 , 8 , 20
   Shiftin Miso , Sck , Alog_x_kanan , 2 , 8 , 20
   Shiftin Miso , Sck , Alog_y_kanan , 2 , 8 , 20
   Shiftin Miso , Sck , Alog_x_kiri , 2 , 8 , 20
   Shiftin Miso , Sck , Alog_y_kiri , 2 , 8 , 20
  Ss = 1
Return