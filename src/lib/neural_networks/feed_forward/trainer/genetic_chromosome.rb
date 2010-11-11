require 'init'

class GeneticChromosome

  attr_accessor :genes, :network

  def initialize network, inputs, ideal_outputs, mutation_percent
    @network = network
    @inputs = inputs
    @ideal_outputs = ideal_outputs
    @mutation_percent = mutation_percent
    initialize_genes
    calculate_cost
  end

  def cost
    @cost ||= 0    
  end

  def calculate_cost
    update_network_with_genes
    @cost = @network.calculate_error @inputs, @ideal_outputs
  end

  def mate(father_chromosome, first_child_chromosome, second_child_chromosome)
    first_cut_point = 0 + ((count_of_genes/2).to_i * rand)
    second_cut_point = count_of_genes - ((count_of_genes/2).to_i * rand)

    first_child_chromosome.genes = father_chromosome.genes[0...first_cut_point]+genes[first_cut_point...second_cut_point]+father_chromosome.genes[second_cut_point..-1]
    second_child_chromosome.genes = genes[0...first_cut_point]+father_chromosome.genes[first_cut_point...second_cut_point]+genes[second_cut_point..-1]

    first_child_chromosome.mutate if (rand < @mutation_percent)
    second_child_chromosome.mutate if (rand < @mutation_percent)

    first_child_chromosome.update_network_with_genes
    second_child_chromosome.update_network_with_genes

    first_child_chromosome.calculate_cost
    second_child_chromosome.calculate_cost
  end

  def mutate
    @genes = @genes.collect{ |gene| gene * ((20 * rand) - 20)  }    
  end

  def update_network_with_genes
    @network.weights_from_packed_array @genes
    initialize_genes
  end

  private

  def count_of_genes
    initialize_genes
    @genes.size
  end

  def initialize_genes
    @genes = @network.weights_to_packed_array
  end

end