require 'matrix'
module CommonFunctions
  module MatrixFunctions

    module ClassFunctions

      def randomize(row_size, column_size)
        rows = Array.new(row_size,Array.new(column_size,0).collect{ (rand/(rand)) * ((-1.0) ** rand(2)) })
        Matrix[*rows]
      end

    end

    module InstanceFunctions

      def product_with_given_column(matrix, column_index)
        column = Matrix.column_vector matrix.column(column_index)
        (self*column)[0,0]
      end

    end

  end
end
