$regfile = "m8def.dat"
'$sim
$crystal = 16000000

Config Portc = Output

Rs Alias Portc.0
Lcd_en Alias Portc.1
Db4 Alias Portc.2
Db5 Alias Portc.3
Db6 Alias Portc.4
Db7 Alias Portc.5
'###############################################################################
Declare Sub Lcd_cmd(byval Cmd As Byte)
Declare Sub Lcd_char(byval Char As Byte)
Declare Sub Lcd_string(byval Text As String)
Declare Sub Lcd_init()

'*******************************************************************************
Dim C As String * 16
'C = "Karan"
Call Lcd_init()
 'Call Lcd_char(69)
Call Lcd_string( "Karan")

End                                                         'end program




'*******************************************************************************


Sub Lcd_init()

   Call Lcd_cmd(&H28)
   Call Lcd_cmd(&H0e)
   Call Lcd_cmd(&H06)
   Call Lcd_cmd(&H01)
   Call Lcd_cmd(&H02)


   'Call Lcd_cmd(&H80)
   Waitus 50




End Sub



Sub Lcd_cmd(byval Cmd As Byte)


   Reset Rs
   Set Lcd_en
   Db7 = Cmd.7
   Db6 = Cmd.6
   Db5 = Cmd.5
   Db4 = Cmd.4

   Waitus 5
   Reset Lcd_en
   Waitus 2
   Set Lcd_en
   Db7 = Cmd.3
   Db6 = Cmd.2
   Db5 = Cmd.1
   Db4 = Cmd.0
   Waitus 50

   Reset Lcd_en
   Waitus 2
   Reset Lcd_en

   Waitus 50

End Sub


Sub Lcd_char(byval Char As Byte)

   Set Rs
   Reset Lcd_en
   Set Lcd_en
   Db7 = Char.7
   Db6 = Char.6
   Db5 = Char.5
   Db4 = Char.4
   Reset Lcd_en
   Waitus 2
   Set Lcd_en


   Db7 = Char.3
   Db6 = Char.2
   Db5 = Char.1
   Db4 = Char.0

   Reset Lcd_en
   Waitus 2
   Set Lcd_en


   Waitms 1


End Sub

Sub Lcd_string(byval Text As String)

   Dim Words(10) As String * 1 , Temp As Integer , I As Integer , L As Integer , Temp2 As Byte
   L = Len(text)

   Temp = Split(text , Words(1) , "")
   For I = 1 To L Step 1
   Reset Rs
   Temp2 = Asc(words(i))
   '   Call Lcd_cmd(&H28)
   'Call Lcd_cmd(&H0e)
   Call Lcd_cmd(&H06)
   'Call Lcd_cmd(&H01)
   'Call Lcd_cmd(&H02)

   Call Lcd_char(temp2)
   Next I

End Sub



