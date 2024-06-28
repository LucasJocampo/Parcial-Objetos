class Bot {
	var Hogwarts = new Hogwart()
	var property cargaElectrica
	var property tipoAceite
	const property hechizos = []
	method cambiarAceite(nuevo) = self.tipoAceite(nuevo) 
	method cambiarCargaElecrica(nueva){
		cargaElectrica = nueva
	}
	method inactivo() = self.cargaElectrica()==0
	method cantidadHechizos() = hechizos.size()
	method aprenderHechizo(hechizo)= hechizos.add(hechizo)
	method disminuirCargaElectrica(cantidad)= cargaElectrica-cantidad
	
}

class Estudiante inherits Bot {
	var property casa = Hogwarts
	method experimentado() = self.cantidadHechizos() >3 && self.cargaElectrica() > 50
	method irClase(materia)= materia.enseniarHechizo(self)
	method lanzarHechizo(hechizo,objetivo){hechizo.golpear(self,objetivo)}
	method loSabe(hechizo)= hechizos.contains(hechizo)
	method asignarCasa(asignada) {
		casa = asignada
	}
}
class Profesor inherits Bot {
	var cantidadMaterias = 0
	var property casa = Hogwarts
	method incrementarMaterias(){
		return cantidadMaterias + 1
	}  
	method experimentado()= self.cantidadHechizos() >3 && self.cargaElectrica() > 50 && cantidadMaterias>= 2
	method asignarCasa(asignada) {
		casa = asignada
	}
}

// CASAS
class Hogwart {
	const integrantes = #{}
	method esPeligrosa() = self.cantidadSucios()> self.cantidadPuros()
	method sumarIntegrantes(estudiante)= integrantes.add(estudiante)
	method cantidadSucios () = integrantes.count({e=>e.tipoAceite() == "Sucio"})
	method cantidadPuros() = integrantes.count({e=>e.tipoAceite() == "Puro"})
}
class Gryffindor inherits Hogwart{
	override method esPeligrosa() = false
}
class Slytherin inherits Hogwart{
	override method esPeligrosa() = true
}
class Ravenclaw inherits Hogwart{
	
}
class Hufflepuff inherits Hogwart{
	
}

//Hechizos
class Hechizo{
	method golpear(atacante,defensor)
}

class Inmobilus inherits Hechizo{
	override method golpear(atacante,defensor) {
		const x = defensor.disminuirCargaElectrica(50)
		defensor.cambiarCargaElecrica(x)
	}
}
class SectumSempra inherits Hechizo{
		override method golpear(atacante,defensor){
			if (atacante.experimentado() && defensor.tipoAceite()=="Puro"){
				defensor.cambiarAceite("Sucio")
			}
			
		}
}
class Avadakedabra inherits Hechizo{
	override method golpear(atacante,defensor) {
		if(atacante.tipoAceite()== "Sucio"|| atacante.casa().esPeligrosa())
		defensor.cargaElectrica(0) 
	} 
}
class HechizoComun inherits Hechizo{
	override method golpear(atacante,defensor) {
		if(atacante.cargaElectrica()> defensor.cargaElectrica()){
			defensor.cargaElectrica(5)
		}
	} 
}

//Materias
class Materia{
	var profesor
	var hechizoEnsenia
	method asignarProfesor(){
		profesor.incrementarMaterias()
	}
	method enseniarHechizo(estudiante){
		estudiante.aprenderHechizo(hechizoEnsenia)
	}
}

//Sombrero
class SombreroSeleccionador inherits Bot {
	var Gryffindor= new Gryffindor()
	var Slytherin = new Slytherin()
	var Ravenclaw= new Ravenclaw()
	var Hufflepuff= new Hufflepuff()
	const property casas = [Gryffindor,Slytherin,Ravenclaw,Hufflepuff]
	var x = 0
	method asignarCasa(estudiante){
		if(x<4){
		var asignada = casas.get(x)
		x = x+1
		estudiante.asignarCasa(asignada)	
		}
		else{
			x=0
		}
	}
}

