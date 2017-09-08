<?php

namespace Illuminate\Session;

use Carbon\Carbon;
use SessionHandlerInterface;
use Illuminate\Database\QueryException;
use Illuminate\Database\ConnectionInterface;

class DatabaseSessionHandler implements SessionHandlerInterface, ExistenceAwareInterface
{
    /**
     * The database connection instance.
     *
     * @var \Illuminate\Database\ConnectionInterface
     */
    protected $connection;

    /**
     * The name of the session table.
     *
     * @var string
     */
    protected $table;

    /**
     * The number of minutes the session should be valid.
     *
     * @var int
     */
    protected $minutes;

    /**
     * The existence state of the session.
     *
     * @var bool
     */
    protected $exists;

    /**
     * Create a new database session handler instance.
     *
     * @param  \Illuminate\Database\ConnectionInterface  $connection
     * @param  string  $table
     * @param  int  $minutes
     * @return void
     */
    public function __construct(ConnectionInterface $connection, $table, $minutes)
    {
        $this->table = $table;
        $this->minutes = $minutes;
        $this->connection = $connection;
    }

    /**
     * {@inheritdoc}
     */
    public function open($savePath, $sessionName)
    {
        return true;
    }

    /**
     * {@inheritdoc}
     */
    public function close()
    {
        return true;
    }

    /**
     * {@inheritdoc}
     */
    public function read($sessionId)
    {
        $session = (object) $this->getQuery()->find($sessionId);

        if (isset($session->last_activity)) {
            if ($session->last_activity < Carbon::now()->subMinutes($this->minutes)->getTimestamp()) {
                $this->exists = true;

                return;
            }
        }

        if (isset($session->payload)) {
            $this->exists = true;

            return base64_decode($session->payload);
        }
    }

    /**
     * {@inheritdoc}
     */
    public function write($sessionId, $data)
    {
        if ($this->exists) {
            $this->performUpdate($sessionId, $data);
        } else {
            $this->performInsert($sessionId, $data);
        }

        $this->exists = true;
    }

    /**
     * Perform an insert operation on the session ID.
     *
     * @param  string  $sessionId
     * @param  string  $data
     * @return void
     */
    protected function performInsert($sessionId, $data)
    {
        try {
            return $this->getQuery()->insert([
                'id' => $sessionId, 'payload' => base64_encode($data), 'last_activity' => time(),
            ]);
        } catch (QueryException $e) {
            $this->performUpdate($sessionId, $data);
        }
    }

    /**
     * Perform an update operation on the session ID.
     *
     * @param  string  $sessionId
     * @param  string  $data
     * @return int
     */
    protected function performUpdate($sessionId, $data)
    {
        return $this->getQuery()->where('id', $sessionId)->update([
            'payload' => base64_encode($data), 'last_activity' => time(),
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function destroy($sessionId)
    {
        $this->getQuery()->where('id', $sessionId)->delete();
    }

    /**
     * {@inheritdoc}
     */
    public function gc($lifetime)
    {
        $this->getQuery()->where('last_activity', '<=', time() - $lifetime)->delete();
    }

    /**
     * Get a fresh query builder instance for the table.
     *
     * @return \Illuminate\Database\Query\Builder
     */
    protected function getQuery()
    {
        return $this->connection->table($this->table);
    }

    /**
     * Set the existence state for the session.
     *
     * @param  bool  $value
     * @return $this
     */
    public function setExists($value)
    {
        $this->exists = $value;

        return $this;
    }
}
