defmodule Ros.Logic do
  @vsn 1

  @moduledoc false

  use Broadway
  alias Broadway.Message


  @doc """
  @khdt data...

  ### start_link
  """
  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: RosBroadway,
      context: %{},
      producers: [
        default: [
          module: {BroadwayRabbitMQ.Producer,
            queue: "ros_orders",
            qos: [
              prefetch_count: 50,
            ]
          },
          stages: 2
        ]
      ],
      processors: [
        default: [
          stages: 50
        ]
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 1500,
          stages: 5
        ],
        special: [
          stages: 1,
          batch_size: 5,
          batch_timeout: 1500,
        ]
      ]
    )
  end

  def handle_message(_processor, message, _context) do
    msg = Ros.Logic.Transformer.transform_message_to_broadwaymessage(message.data, [:service])
    Message.update_data(msg, &process_data/1)

  end

  def handle_batch(_, messages, _, _) do
    messages
  end

  defp process_data(messagemodel) do
    Ros.Logic.OrderPipeline.process(messagemodel)

  end


  @spec handle_message(atom, list, list) :: struct
  def ack(ack_ref, successful, failed) do
  # credo:disable-for-lines:3
    IO.inspect(ack_ref, label: "ack - ack_ref")
    IO.inspect(successful, label: "ack - successful")
    IO.inspect(failed, label: "ack - failed")
  end

end
