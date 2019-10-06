#!/usr/bin/env nextflow

import org.codehaus.groovy.runtime.InvokerHelper
class Main {
    int exponent = 2
    int power(int n) { 2** n}
    def go() {
        println "2^${exponent}==${power(exponent)}"
    }
    static void main(String[] args) {
        InvokerHelper.runScript(Main, args)
    }
}

params.michael = false
cheers = Channel.from 'Bonjour', 'Ciao', 'Hello', 'Hola'

executor {
    name='slurm'
}

if (params.michael) {
  process sayHelloToMichael {
    input:
      val x from cheers
    output:
      stdout into out_txt
    script:
        m = new Main()
        n = new Main(exponent: 4)
        m.go()
        n.go()
      """
      printf '$x, Michael!'
      """
  }
} else {
  process sayHello {
    input:
      val x from cheers
    output:
      stdout into out_txt
    script:
      """
      printf '$x, world!'
      """
    }
}

out_txt.println{ it.trim() }