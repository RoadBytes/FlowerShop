# handles subsets that sum to target value
class SubsetOnTarget
  attr_reader :total_set, :target_value, :acceptable_subsets

  def initialize(total_set, target_value)
    @total_set          = total_set
    @target_value       = target_value
    @acceptable_subsets = []
    @all                = nil
  end

  def all
    @all ||= subset_step_k([], -1)
  end

  def last
    all.nil? ? nil : all.last
  end

  def subset_step_k(subset, k_step)
    current_sum = subset.inject(:+).to_i

    # add subset if subset_on_target
    acceptable_subsets << subset if subset_on_target(current_sum)

    # stop looking if termination condition in next set
    return acceptable_subsets if termination_condition?(current_sum, k_step + 1)

    # look at each next step (with next element and without)
    subset_step_k_plus_one(subset, k_step)

    acceptable_subsets
  end

  def termination_condition?(current_sum, next_k_step)
    k_step_out_of_bounds?(next_k_step) ||
      ending_step?(current_sum, next_k_step)
  end

  def k_step_out_of_bounds?(next_k_step)
    return true if next_k_step >= total_set.size
  end

  def ending_step?(current_sum, next_k_step)
    remainder_sum = total_set[next_k_step..-1].inject(:+).to_i
    next_element  = total_set[next_k_step]

    (current_sum + next_element) > target_value ||
      (current_sum + remainder_sum) < target_value
  end

  def subset_on_target(current_sum)
    current_sum == target_value
  end

  def subset_step_k_plus_one(subset, k_step)
    including_subset = subset + [total_set[k_step + 1]]
    excluding_subset = subset

    subset_step_k(including_subset, k_step + 1)
    subset_step_k(excluding_subset, k_step + 1)
  end
end
