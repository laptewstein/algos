# https://leetcode.com/problems/maximum-profit-in-job-scheduling/
# We have n jobs, where every job is scheduled to be done from startTime[i] to endTime[i], obtaining a profit of profit[i].

# You're given the startTime, endTime and profit arrays, return the maximum profit you can take such that there are no two jobs in the subset with overlapping time range.

# If you choose a job that ends at time X you will be able to start another job that starts at time X.

# Input: startTime = [1,2,3,3], endTime = [3,4,5,6], profit = [50,10,40,70]
# Output: 120
# Explanation: The subset chosen is the first and fourth job. 
# Time range [1-3]+[3-6] , we get profit of 120 = 50 + 70.


def job_scheduling(start_time, end_time, profit)
  job_count = profit.count
  jobs      = start_time
    .zip(end_time, profit)
    .sort_by { |job_start, _, _| job_start } # sort on start date for later lookups

  recursive_lookup = lambda do |idx|
    return 0 unless idx < job_count

    current_job        = jobs[idx]
    next_candidate_idx = idx.succ

    # discover the next job to start (on or after) current
    # keep looking for the next job to schedule until:
    #   - index is out-of-bounds OR
    #   - current job finishes after next
    while next_candidate_idx < job_count && current_job[1] > jobs[next_candidate_idx].first
      next_candidate_idx = next_candidate_idx.succ
    end
    future_profit      = recursive_lookup.call(next_candidate_idx)
    # it might make sense to drop current job and _schedule_the_very_next_in_sequential_order
    # rather than take current and find the next one which will be starting _after_ current
    ignore_current_job = recursive_lookup.call(idx.succ)
    [current_job.last + future_profit, ignore_current_job].max
  end

  # start scheduling (with inndex of first job)
  recursive_lookup.call(0)
end

puts job_scheduling([1, 2, 3, 3], [3, 4, 5, 6], [50, 10, 40, 70]) == 120
