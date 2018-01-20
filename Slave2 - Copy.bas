$regfile = "m128def.dat"
$crystal = 16000000

Config Lcdpin = Pin , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2 , E = Porta.4 , Rs = Porta.3
Config Lcd = 16 * 2



Dim Twi_control As Byte
Dim Twi_status As Byte
Dim Twi_data As Byte

Dim Newbyte As Byte
Enable Interrupts
Enable Twi
Declare Sub Twi_init_slave
On Twi Geti2c Nosave
Twi_data = 0
Call Twi_init_slave

Do

Loop

 End

Sub Twi_init_slave
     Twsr = 0
     Twdr = &HFF
     Twar = &H40
     Twcr = &B01000101

End Sub

Geti2c:

     Newbyte = 0


   Twi_control = Twcr And 128

     If Twi_control = &H80 Then
         Twi_status = Twsr And 248

   If Twi_status = 128 Or Twi_status = &H88 Then
   Twi_data = Twdr
   Newbyte = 1
   End If

   Twcr = &B11000101
   End If
   Cls
   Lcd Twi_data

Return