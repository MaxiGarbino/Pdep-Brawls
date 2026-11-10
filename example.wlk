class Personaje{
  var property copas
  method destreza()
  method tieneEstrategia()

}
class Arquero inherits Personaje{
  var agilidad
  var rango
  override method tieneEstrategia() = rango >100
  override method destreza() = agilidad*rango
}
class Ballestero inherits Arquero{
  override method destreza() = super() * 2
}
class Guerrera inherits Personaje{
  var estrategia
  var fuerza
  override method tieneEstrategia() = estrategia
  override method destreza() = 1.5*fuerza
}

class Mision {
	var tipo
  method participantes()
	method esSuperada()
  method copasJuego()
	method copasFinal() = tipo.ajustar(self.copasJuego())
	method puedeJugarse()

	method hacerMision() {
		if (not self.puedeJugarse()) self.error("Mision no puede comenzar")

		if (self.esSuperada())
			self.participantes().forEach({ p => p.copas(p.copas() + self.copasFinal()) })
		else
			self.participantes().forEach({ p => p.copas(p.copas() - self.copasFinal()) })
	}
}
class Individual inherits Mision {
	const dificultad
	const participante

	override method participantes() = [participante]
	override method copasJuego() = 2 * dificultad
	override method puedeJugarse() = participante.copas() >= 10
	override method esSuperada() =
		participante.tieneEstrategia() || participante.destreza() > dificultad
}

class Equipo inherits Mision {
	const equipo = []

	override method participantes() = equipo
	override method copasJuego() = 50 / equipo.size()
	override method puedeJugarse() = equipo.sum({ p => p.copas() }) >= 60
	override method esSuperada() =
		equipo.count({ p => p.tieneEstrategia() }) > equipo.size() / 2
			|| equipo.all({ p => p.destreza() > 400 })
}
object comun{
  method ajustar(copas) = copas
}
class Boost{
  var property multiplicador
  method ajustar(copas) = copas*multiplicador
}
class Bonus{
  method ajustar(copas) = copas+1
}

//5) en el punto 3 aplico polimorfismo al tratar a cada tipo con el mismo nombre de metodo, cada tipo aplica su propia logica, pero la mision no le interes a qhace internamente