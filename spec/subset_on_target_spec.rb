# frozen_string_literal: true

require_relative '../lib/subset_on_target.rb'

describe SubsetOnTarget do
  describe '#create_matrix' do
    it 'initializes a matrix with sized 4 total set' do
      expected_matrix = [[true], [true], [true], [true]]

      subset_calculator = SubsetOnTarget.new([3, 3, 5, 5], 6)
      subset_calculator.create_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end

    it 'initializes a matrix with sized 2 total set' do
      expected_matrix = [[true], [true]]

      subset_calculator = SubsetOnTarget.new([3, 5], 3)
      subset_calculator.create_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end
  end

  describe '#fillin_matrix' do
    it 'fills in the matrix of 2' do
      expected_matrix = [
        [true, false, false, true],
        [true, false, false, true]
      ]

      subset_calculator = SubsetOnTarget.new([3, 5], 3)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end

    it 'fills in the matrix of 4' do
      expected_matrix = [
        [true, false, false, true, false, false, false],
        [true, false, false, true, false, false, true],
        [true, false, false, true, false, true, true],
        [true, false, false, true, false, true, true]
      ]

      subset_calculator = SubsetOnTarget.new([3, 3, 5, 5], 6)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end

    it 'works for args [1, 2, 4, 5, 9], 15' do
      expected_matrix = [
        [true, true, false, false, false, false, false, false, false, false,
         false, false, false, false, false, false],
        [true, true, true, true, false, false, false, false, false, false,
         false, false, false, false, false, false],
        [true, true, true, true, true, true, true, true, false, false, false,
         false, false, false, false, false],
        [true, true, true, true, true, true, true, true, true, true, true,
         true, true, false, false, false],
        [true, true, true, true, true, true, true, true, true, true, true,
         true, true, true, true, true]
      ]

      subset_calculator = SubsetOnTarget.new([1, 2, 4, 5, 9], 15)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end

    it 'works for args [2, 3], 6' do
      expected_matrix = [
        [true, false, true, false, false, false, false],
        [true, false, true, true,  false, true,  false]
      ]

      subset_calculator = SubsetOnTarget.new([2, 3], 6)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.matrix).to eq expected_matrix
    end
  end

  describe '#subset_on_target' do
    it 'returns [3] for [3, 5], 3' do
      expected_subset = [3]

      subset_calculator = SubsetOnTarget.new([3, 5], 3)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.subset_on_target).to eq expected_subset
    end

    it 'returns nil for [3, 5], 4' do
      subset_calculator = SubsetOnTarget.new([3, 5], 4)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.subset_on_target).to be_nil
    end

    it 'return [1, 5, 9] for args [1, 2, 4, 5, 9], 15' do
      subset_calculator = SubsetOnTarget.new([1, 2, 4, 5, 9], 15)
      subset_calculator.create_matrix
      subset_calculator.fillin_matrix

      expect(subset_calculator.subset_on_target).to eq [9, 4, 2]
    end
  end
end
