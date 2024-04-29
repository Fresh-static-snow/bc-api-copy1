class UpdateDatesToUtcFormat < ActiveRecord::Migration[6.0]
  def up
    Match.where.not(start_at: nil).update_all("start_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN start_at - INTERVAL '1 hour' ELSE start_at - INTERVAL '1 hour' END")
    Match.where.not(end_at: nil).update_all("end_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN end_at - INTERVAL '1 hour' ELSE end_at - INTERVAL '1 hour' END")

    Tournament.where.not(start_at: nil).update_all("start_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN start_at - INTERVAL '1 hour' ELSE start_at - INTERVAL '1 hour' END")
    Tournament.where.not(end_at: nil).update_all("end_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN end_at - INTERVAL '1 hour' ELSE end_at - INTERVAL '1 hour' END")
  end

  def down
    Match.where.not(start_at: nil).update_all("start_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN start_at + INTERVAL '1 hour' ELSE start_at + INTERVAL '1 hour' END")
    Match.where.not(end_at: nil).update_all("end_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN end_at + INTERVAL '1 hour' ELSE end_at + INTERVAL '1 hour' END")

    Tournament.where.not(start_at: nil).update_all("start_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN start_at + INTERVAL '1 hour' ELSE start_at + INTERVAL '1 hour' END")
    Tournament.where.not(end_at: nil).update_all("end_at = CASE WHEN start_at < '2023-10-29 03:00:00' THEN end_at + INTERVAL '1 hour' ELSE end_at + INTERVAL '1 hour' END")
  end
end
