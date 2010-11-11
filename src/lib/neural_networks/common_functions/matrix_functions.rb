require 'matrix'
module CommonFunctions
  module MatrixFunctions

    module ClassFunctions

      def randomize(row_size, column_size)
        rows = (0...row_size).collect do
          (0...column_size).collect do
            rand * (-1 ** rand(3))
          end
        end
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
