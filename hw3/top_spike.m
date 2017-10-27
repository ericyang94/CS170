function [spike_freq,spike_power] = top_spike(frequency_values,power_values)

spike = find(power_values == max(power_values));
while (frequency_values(spike) < 100)
  power_values(spike) = 0;
  spike = find(power_values == max(power_values));
endwhile
spike_freq = frequency_values(spike);
spike_power = power_values(spike);
