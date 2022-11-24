#### https://gist.github.com/Whitespace/8da24419555093fa26ea3abe5d5f2d9e

## Pitch
We want to write a service/class that allows us to add and count the number of events received in the last `W` milliseconds where `W` is defined by the user.

```
class EventsCounter {

  /*
    Initialise the class with the given timeframe
  */
  EventsCounter(int timeframeMS)

  /*
    Adds a new event at time `eventTimeMS`
  */
  void add(int eventTimeMS)

  /*
    Counts and returns the number of events that has been added in the 
    past `timeframeMS` (including the new one)
    Specifically, return the number of requests that have happened 
    in the inclusive range [eventTimeMS - timeframeMS, eventTimeMS]
  */
  int count()
}
```

## Example
```
EventsCounter counter = new EventsCounter(10);
```

<img width="1073" alt="Screenshot 2022-03-19 at 14 24 46" src="https://user-images.githubusercontent.com/3590/200856576-d16cef0e-4cae-4ad9-8e09-07fd26f2596a.png">

```
counter.add(2);
counter.count(); // We are looking for all the requests made in the [0,2] interval, so we return 1
```

<img width="1048" alt="Screenshot 2022-03-19 at 14 25 29" src="https://user-images.githubusercontent.com/3590/200856575-2bcef29f-6ea6-4919-9eb8-890faef4b419.png">

```
counter.add(8);
counter.count(); // [0,8] interval, return 2
```

<img width="1070" alt="Screenshot 2022-03-19 at 14 26 14" src="https://user-images.githubusercontent.com/3590/200856573-0a0c594a-8063-4ac7-aa90-1e0d4ae30b31.png">

```
counter.add(11);
counter.count(); // [1, 11] interval, return 3
```

<img width="1086" alt="Screenshot 2022-03-19 at 14 26 59" src="https://user-images.githubusercontent.com/3590/200856571-71bcb144-edcd-4936-bfb1-85809132cda7.png">

```
counter.add(14);
counter.count(); // [4, 14] interval return 3
```

<img width="1068" alt="Screenshot 2022-03-19 at 14 27 40" src="https://user-images.githubusercontent.com/3590/200856566-82bd3ec8-f704-4e84-b267-f2e577810091.png">

```
counter.add(25);  
counter.count(); // [15 25] interval, return 1
```

It is **guaranteed** that every call to `add` uses a strictly larger value of `eventTimeMS` than the previous call. Both `eventTimeMS` and `timeframeMS` are values expressed in milliseconds. 

### Constraints:
- `1 <= eventTimeMS <= 10^9`
- `1 <= timeframeMS <= 5000`
- Each test case will call `add` with strictly increasing values of `eventTimeMS`
- At most `10^6` calls will be made to `add`

--------------

```
require 'pp'

class EventsCounter
  def initialize(window)
    @window_width = window
    @window_start = 0
    @storage      = []
  end

  def add(eventTimeMS)
    @window_start = eventTimeMS - @window_width
    @storage << eventTimeMS
    @storage = @storage.select { |event| event > @window_start }
  end

  def count()
    @storage.count
  end

  # def count()
  #   events = @storage.select do |event_ts|
  #     @window_start <= event_ts
  #   end
  #   [events.count, events]
  # end
end

counter = EventsCounter.new(1_000_000)
#for eventTimeMS in [2, 8, 11, 14, 25] do
#   counter.add(eventTimeMS)
#   PP.pp counter.count
# end

for eventTimeMS in (1..1_000_000) do
  counter.add(eventTimeMS)
end

puts counter.count()
```
