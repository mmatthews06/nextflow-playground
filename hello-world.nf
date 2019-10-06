#!/usr/bin/env nextflow

params.michael = false
cheers = Channel.from 'Bonjour', 'Ciao', 'Hello', 'Hola'

process sayHelloToMichael {
  input:
    val x from cheers
  output:
    stdout into out_txt
  when:
    params.michael == true
  script:
    """
    printf '$x, Michael!'
    """
}

process sayHello {
  input:
    val x from cheers
  output:
    stdout into out_txt
  when:
    params.michael == false
  script:
    """
    printf '$x, world!'
    """
}

out_txt.println{ it.trim() }