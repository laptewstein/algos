# https://leetcode.com/problems/restore-ip-addresses/

# A valid IP address consists of exactly four integers separated by single dots. Each integer is between 0 and 255 (inclusive) and cannot have leading zeros.

# For example, "0.1.2.201" and "192.168.1.1" are valid IP addresses, but "0.011.255.245", "192.168.1.312" and "192.168@1.1" are invalid IP addresses.
# Given a string s containing only digits, return all possible valid IP addresses that can be formed by inserting dots into s. You are not allowed to reorder or remove any digits in s. You may return the valid IP addresses in any order.

def restore_ip_addresses(s)
  input_length = s.length
  resolved_ips = []
  return resolved_ips unless (4...13).include?(input_length)

  dfs = lambda do |l, separators, ip_address|
    if separators == 4 
      return if ip_address.length < input_length + separators
      resolved_ips << ip_address[0...-1]
    end

    right_bondary = [l + 3, input_length].min
    (l...right_bondary).map do |r|
      zone = s[l..r]
      next if zone.to_i > 255
      next if s[l] == "0" && l != r # leading zero and its not a single ".0." in the zone
      dfs.call(r.succ, separators.succ, ip_address + zone + '.')
    end
  end
  dfs.call(0, 0, "")
  resolved_ips
end

tests = { 
  "25525511135" => ["255.255.11.135","255.255.111.35"],
  "0000"        => ["0.0.0.0"],
  "101023"      => ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]
}

# tests
tests.map do |concatenated, ip_addresses|
  results = restore_ip_addresses(concatenated)
  puts concatenated + ': ' + results.inspect
  results.sort == ip_addresses.sort
end

# 25525511135:  ["255.255.11.135", "255.255.111.35"]
# 0000:         ["0.0.0.0"]
# 101023:       ["1.0.10.23", "1.0.102.3", "10.1.0.23", "10.10.2.3", "101.0.2.3"]

