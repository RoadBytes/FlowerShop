# frozen_string_literal: true

# handles subsets that sum to target value
class SubsetOnTarget
  attr_reader :total_set, :target_value
  attr_accessor :matrix, :subset

  def initialize(total_set, target_value)
    @total_set    = total_set
    @target_value = target_value
    @matrix       = []
    @subset       = []
  end

  def run
    return if total_set.size.zero?
    create_matrix
    fillin_matrix
    subset_on_target
  end

  def create_matrix
    total_set.size.times do
      matrix << [true]
    end
  end

  def fillin_matrix
    columns = target_value
    rows = total_set.size

    0.upto(rows) do |row|
      1.upto(columns) do |column|
        matrix[row][column] = position_above(row, column) ||
                              position_above_and_back(row, column)
      end
    end
  end

  def subset_on_target
    determined_subset if matrix[-1][-1]
  end

  private def position_above(row, column)
    return column == total_set[row] if (row - 1).negative?

    matrix[row - 1][column]
  end

  private def position_above_and_back(row, column)
    return false if (column - total_set[row]).negative?

    matrix[row - 1][column - total_set[row]] || false
  end

  private def determined_subset
    current = { row: total_set.size - 1, column: target_value }

    while current[:row].positive? && current[:column].positive?
      add_matrix_item_to_subset_and_move_left(current)
      move_up_and_add_matrix_item(current)
    end

    subset
  end

  private def add_matrix_item_to_subset_and_move_left(current)
    return if position_above(current[:row], current[:column])

    subset << total_set[current[:row]]
    current[:column] -= total_set[current[:row]]
  end

  private def move_up_and_add_matrix_item(current)
    current[:row] -= 1
    subset << total_set[current[:row]] if current[:row].zero? &&
                                          current[:column].positive?
  end
end
