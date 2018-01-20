
$regfile = "m8def.dat"
$crystal = 16000000



Config Lcdpin = Pin , Db4 = Portc.2 , Db5 = Portc.3 , Db6 = Portc.4 , Db7 = Portc.5 , E = Portc.1 , Rs = Portc.0
Config Lcd = 16 * 2
Config Portd.7 = Output
Config Portd.6 = Output
Config Portb.0 = Output
Config Portd.5 = Output
Config Portb.1 = Input
Ddrb.1 = 0
Ddrd.7 = 1
Ddrd.0 = 1
Ddrd.6 = 1
Ddrd.5 = 1
'*******************************************************************************


Clk Alias Portb.0
Datapin Alias Pinb.1
Command Alias Portd.7
Attention Alias Portd.6
Ackn Alias Portd.5
'*******************************************************************************
Dim Temp As Byte , D0 As Byte , D1 As Byte , D2 As Byte , D3 As Byte , D4 As Byte , D5 As Byte , D6 As Byte , D7 As Byte , D8 As Byte , D9 As Byte
Dim I As Integer , X As Integer
Declare Sub Sendbyte(byval Cmd As Byte)
Declare Sub Configenter()
Declare Sub Configanalog()
Declare Sub Poll()
Declare Sub Exitconfig()
'*******************************************************************************
 Cls
Set Clk
Set Ackn
Set Attention
Lcd "PS2"
Wait 1

Cls

For X = 0 To 10
Call Configenter()
Call Configanalog()
Call Exitconfig()
Next X

Lcd "Out of mode"
Wait 2
Do
   Call Poll()
   Cls
   'Lcd D0
   'lcd ":"
   Lcd D1
   Lcd ":"
   Lcd D2
   Lcd ":"
   Lcd D3
   Lcd ":"

   Lowerline
     Lcd D4
   Lcd ":"
   Lcd D5
   Lcd ":"
   Lcd D6
   Lcd ":"
   Lcd D7
   Lcd ":"
   Lcd D8
   Waitms 10

Loop
End

'*******************************************************************************
Sub Sendbyte(byval Cmd As Byte)

     Reset Clk
      For I = 0 To 7


         If Cmd.i = 0 Then
            Reset Command

         Else
            Set Command

         End If

         Reset Clk
         Waitus 2

         If Datapin = 0 Then
            Temp.i = 0
         Else
            Temp.i = 1
         End If




         Set Clk
      Next I
  Waitus 10
   'Shiftin Datapin , Clk , Temp , 2 , 8 , 20
End Sub
'*******************************************************************************
Sub Configenter()

Reset Attention
Call Sendbyte(&H01)
Call Sendbyte(&H43)
Call Sendbyte(&H00)
Call Sendbyte(&H01)

Set Attention
 End Sub
'*******************************************************************************
Sub Configanalog()

Reset Attention
Call Sendbyte(&H01)
Call Sendbyte(&H44)
Call Sendbyte(&H00)
Call Sendbyte(&H01)
Call Sendbyte(&H03)
Set Attention

End Sub
'*******************************************************************************
Sub Exitconfig()

Reset Attention
Call Sendbyte(&H01)
Call Sendbyte(&H43)
Call Sendbyte(&H00)
Call Sendbyte(&H00)
Call Sendbyte(&H5a)
Call Sendbyte(&H5a)
Call Sendbyte(&H5a)
Call Sendbyte(&H5a)
Call Sendbyte(&H5a)

Set Attention
End Sub
'*******************************************************************************
Sub Poll()
Reset Attention
   Call Sendbyte(&H01)
   Call Sendbyte(&H42)
   Call Sendbyte(&H00)
   D0 = Temp
   Call Sendbyte(&H00)
   D1 = Temp
   Call Sendbyte(&H00)
   D2 = Temp
   Call Sendbyte(&H00)
   D3 = Temp
   Call Sendbyte(&H00)
   D4 = Temp
   Call Sendbyte(&H00)
   D5 = Temp
   Call Sendbyte(&H00)
   D6 = Temp
   Call Sendbyte(&H00)
   D7 = Temp
   Call Sendbyte(&H00)
   D8 = Temp


Set Attention
End Sub
'*******************************************************************************