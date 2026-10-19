class Criatura{
  var poderMagico
  var astucia
  var rol

  method poderMagico() = poderMagico
  method astucia() = astucia
  method rol() = rol 

  method poderOfensivo() = (poderMagico * 10) + rol.poderOfencivoExtra()
  
  method esAstuta()

  method esExtraordinario() = rol.esExtraordinario(self) 

  method cambiarDeRol() {
    rol = rol.rolSiguiente()
  }

  method pierdePoder() {
    poderMagico -= poderMagico * 0.15
  }

}

class Hadas inherits Criatura{
  var kmVolar = 2

  method kmVolar() = kmVolar
  method aumentaKm(masKm) {
    kmVolar = (kmVolar + masKm).min(25).max(0)
  }   

  override method esAstuta() = astucia > 50 

  override method esExtraordinario() = super() and self.kmVolar() > 10
}

class Duende inherits Criatura{

  override method poderOfensivo() = super() * 1.1

  override method esAstuta() = false 
}



/*-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-*/

class Guardian{

  method poderOfencivoExtra() = 100
  method esExtraordinario(unaCriatura) = unaCriatura.poderMagico() > 50  

  method rolSiguiente() {
    const masc = new Mascota(edad = 1, tieneCuernos = false)
    return new Domador(mascotas = [masc])
  }
}

class Hechicero{

  method poderOfencivoExtra() = 0

  method esExtraordinario(unaCriatura) = false

   method rolSiguiente(){
    return new Guardian() 
   }
}

class Domador{
  const mascotas = []

  method mascotas() = mascotas
  method agregarMascota(unaMascota) {
    mascotas.add(unaMascota)
  }
  method sacarMascota(unaMascota) {
    mascotas.remove(unaMascota)
  }
  method edadMascota(unaMascota) = unaMascota.edad()
  method tieneCuernosMascota(unaMascota) = unaMascota.tieneCuernos()
  method cantMascotas() = mascotas.size()
  method poderOfencivoExtra(){
    return mascotas.count({m => m.tieneCuernos()}) * 150
  }

  method esExtraordinario(unaCriatura){
    return unaCriatura.poderMagico() >= 15 and mascotas.all({m => m.esVeterano()})
  }

  method algunoTieneCuernos() = mascotas.any({m => m.tieneCuernos()})

   method rolSiguiente(){
    if(not self.algunoTieneCuernos()){
        self.error("No se pudo realizar el ritual")
    }

    return new Hechicero()
    
  }
   
}

class Mascota{
  var edad
  var tieneCuernos

  method edad() = edad
  method tieneCuernos() = tieneCuernos  

  method esVeterano() = edad >= 10
}

/*.-.-.-.-.-.-.-..-.-.-.-.-..-.-.-.-.-..-.-.-.-.-.-.-.-.-.-..--.*/

class Colonia{
  const criaturasC = []

  method criaturasC() = criaturasC
  method poderOfensivoC() = criaturasC.sum({c => c.poderOfensivo()})  
  
  method cantDeCriaturas() = criaturasC.size() 

  method perderPoderCriaturas(){
    criaturasC.forEach({c => c.pierdePoder()})
  }
}

class Area{
  var coloni

  method poderDefensivo() 

  method peleaCon(coloniaEnemiga){
    if(coloniaEnemiga.poderOfensivoC() > self.poderDefensivo()){
      coloni = coloniaEnemiga
    }else{
      coloniaEnemiga.pierdePoder()
    }
  }
}

class AreaLosClaros inherits Area{

  override method poderDefensivo() = coloni.poderOfensivoC() + 100

}

class AreaLosCastillos inherits Area{

  override method poderDefensivo() =  coloni.cantDeCriaturas() * 200 //??
 
}