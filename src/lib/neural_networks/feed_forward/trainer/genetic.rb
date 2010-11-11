require 'init'
require 'neural_networks/feed_forward/trainer/genetic_chromosome'

class Genetic

  def initialize(inputs, ideal_outputs, size_of_population, percent_to_mutate, percent_to_mate,&network_builder_block)    
    @inputs = inputs
    @ideal_outputs = ideal_outputs
    @size_of_population = size_of_population
    @percent_to_mutate = percent_to_mutate
    @percent_to_mate = percent_to_mate
    @network_builder_block = network_builder_block
    initialize_chromosomes
  end

  def iteration
    count_to_mate = (@size_of_population * @percent_to_mate).to_i
    count_of_children = count_to_mate * 2
    children_index_position = @size_of_population - count_of_children
    mating_population_size = (@size_of_population * mating_population)


    count_to_mate.times do |index|
      mother_chromosome = @chromosomes[index]
      father_index = ((rand)* mating_population_size).to_i
      father_chromosome = @chromosomes[father_index]
      first_child = @chromosomes[children_index_position]
      second_child = @chromosomes[children_index_position+1]

      mother_chromosome.mate father_chromosome, first_child, second_child
      children_index_position += 2
    end
    
    sort_chromosomes
  end

  def error
    @chromosomes.first.cost   
  end

  def network
    @chromosomes.first.network
  end

  private

  def mating_population
    @percent_to_mate * 2
  end

  def sort_chromosomes
    @chromosomes.sort! { |first, second| first.cost <=> second.cost }
  end

  def initialize_chromosomes
    @chromosomes = (0...@size_of_population).collect do
      network = @network_builder_block.call
      GeneticChromosome.new network, @inputs, @ideal_outputs, @percent_to_mutate
    end
    sort_chromosomes
  end


end