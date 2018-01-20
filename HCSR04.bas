$regfile = "m128def.dat"
$crystal = 16000000
Config Lcdpin = Pin , Db4 = Porta.5 , Db5 = Porta.6 , Db6 = Porta.7 , Db7 = Portg.2 , E = Porta.4 , Rs = Porta.3
Config Lcd = 16 * 2

Config Pine.3 = Input
Config Porte.4 = Output
Config Timer1 = Timer , Prescale = 256

Dim T As Long
Trig Alias Pine.4
Echoes Alias Pine.3

Do

   Reset Porte.4
   Waitus 2
   Set Porte.4
   Waitus 10
   Reset Porte.4

   Do
   If Pine.3 = 1 Then
      Timer1 = 0
      Do
      Loop Until Pine.3 = 0
      T = Timer1
      Exit Do

   End If

   Loop
   Cls

   t=t/2.85
   Lcd T ; " cm"
   Waitms 100
Loop

