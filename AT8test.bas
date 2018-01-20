$regfile = "m8def.dat"

$crystal = 12000000


Lm Alias Pwm1a
Rm Alias Pwm1b

Config Timer1 = Pwm , Pwm = 8 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up , Prescale = 256


Config Portc = Input


Proxy Alias Portc.1

Dim Direction As Bit , Curpos As Bit
Curpos = 0
If Proxy = 1 Then


Direction = 1

Do
Pwm1a = 20
If Proxy = 0 Then
   Curpos = 1
End If
If Proxy = 1 And Curpos = 1 Then
   Pwm1a = 0
   Exit Do
End If
Loop



End If


