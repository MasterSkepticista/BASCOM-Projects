$regfile = "m128def.dat"
$crystal = 16000000
Config Lcdpin = Pin , Db4 = Portd.2 , Db5 = Portd.3 , Db6 = Portd.4 , Db7 = Portd.5 , E = Portd.1 , Rs = Portd.0
Config Lcd = 16 * 2
Config Sda = Portd.1
Config Scl = Portd.0
Dim A As Byte , B As Byte
A = 0
B = A
Cls
Lcd A
Int_flag Alias Twcr.7
Accen Alias Twcr.6
Twien Alias Twcr.2
Inten Alias Twcr.0
Twar = &H80
Twcr = &B11000101
Twsr.1 = 0
Twsr.0 = 0

Enable Interrupts
Enable Twi
On Twi Isr_rec

Do
Select Case Twsr
  Case &H60 : Accen = 0
               Return
  Case &H88 : A = Twdr
               Accen = 1
               Return
  Case &HA0 : Int_flag = 1
               Accen = 1
               Return
End Select
If A <> B Then
Cls
Lcd A
B = A
End If
Loop

End                                                         'end program

Isr_rec:
Int_flag = 1
Return

'(Select Case Twsr
  Case &H60 : Accen = 0
              Intflg = 1
               Return
  Case &H88 : A = Twdr
               Accen = 1
               Intflg = 1
               Return
  Case &HA0 : Intflg = 1
               Accen = 1
               Intflg = 1
               Return
End Select
')