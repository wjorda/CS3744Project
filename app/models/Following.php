<?php
/**
 * Created by PhpStorm.
 * User: kayla
 * Date: 3/22/18
 * Time: 11:09 AM
 */

namespace app\models;

use PDO;

/**
 * Class Following
 * @package app\models
 *
 * Model class for a follow relationship between users.
 */
class Following
{
    private $id = -1;
    private $userFrom = 0;
    private $userTo = 0;

    private $changed = false; // true when the model is no longer in sync with the DB.

    /**
     * Build a Following from database params.
     * @param int $id - Public key of the Following.
     * @param int $userFrom - User who is doing the following.
     * @param int $userTo - User who is being followed.

     * @return Following
     */
    public static function build(int $id, int $follower, int $followee): Following {
        $follow  = new Following();
        $follow->id = $id;
        $follow->userFrom = $follower;
        $follow->userTo = $followee;
        return $follow;
    }

    /**
     * Fetches a Following relationship from the database.
     * @param PDO $db
     * @param int $followingid
     * @return Following|null - null if no such following relationship was found, or if the query failed.
     */
    public static function fetch(PDO $db, int $followingid) : ?Following {
        $fetch_sql = 'SELECT * FROM Following WHERE id = ? LIMIT 1';
        $stmt = $db->prepare($fetch_sql);
        $res = $stmt->execute([$followingid]);

        if ($res == false) {
            error_log("Unable to fetch Following relationship!: " . $stmt->errorCode());
            return null;
        }

        $rows = $stmt->fetchAll(PDO::FETCH_FUNC, 'app\models\Following::build');
        if (sizeof($rows) < 1) {
            error_log("No following relationship matching id: " . $followingid);
            return null;
        } else {
            return $rows[0];
        }
    }

    /**
     * Fetches the list of Following relationships from the database.
     * @param PDO $db
     * @param int $followingid
     * @return Following|null - null if the query failed.
     */
    public static function fetchAll(PDO $db) : ?array {
        $fetch_sql = 'SELECT * FROM Following';
        $stmt = $db->prepare($fetch_sql);
        $res = $stmt->execute();

        if ($res == false) {
            error_log("Unable to fetch Following relationships!: " . $stmt->errorCode());
            return null;
        }

        $rows = $stmt->fetchAll(PDO::FETCH_FUNC, 'app\models\Following::build');
        return $rows;
    }

    /**
     * Deletes a Following relationship from the database.
     * @param PDO $db
     * @param int $followingid
     * @return bool - true if successful
     */
    public static function deleteFollow(PDO $db, int $follower, int $followee ): bool {
      $stmt = $db->prepare('DELETE FROM Following WHERE userFrom = ? AND userTo = ?');
        $res = $stmt->execute([$follower, $followee]);

        if(!$res) {
            error_log('Unable to delete Following relationship!: ' . $stmt->errorCode());
        }

        return $res;
    }

    /**
     * Checks if one user follows another
     * @param PDO $db
     * @param int $userFrom - user who is doing the following
     * @param int $userTo - user who is being followed
     * @return bool - the id of the follow relation (truthy) if the users follow each other, 0 (falsy) otherwise.
     */
    public function checkFollow(PDO $db, int $follower, int $followee): int {

      $stmt = $db->prepare('SELECT id FROM Following WHERE userFrom = ? AND userTo = ? LIMIT 1');
      $stmt->execute([$follower, $followee]);

      $result = 0;
      if ($row = $stmt->fetch(PDO::FETCH_NUM)) {
          $result = $row[0];
      }

      return $result;
    }

    /**
     * Saves the changes made to this following to the database
     * @param PDO $db
     * @return bool - true if successful
     */
    public function commit(PDO $db): bool {
        $res = false;
        if ($this->id == -1) { // new object
            $stmt = $db->prepare('INSERT INTO Following VALUE (0,?,?)');
            $res = $stmt->execute([
                $this->userFrom, $this->userTo
            ]);
        }  else { // update existing
            $stmt = $db->prepare('UPDATE Following SET userFrom = ?, userTo = ? WHERE id = ?');
            $res = $stmt->execute([
                $this->userFrom, $this->userFrom, $this->id
            ]);
        }

        if ($res) { // update token id
            $this->changed = false;
            if ($this->id == -1) {
                $this->id = $db->lastInsertId();
            }
        }
        else {
            error_log("Unable to commit Following object!: " . $stmt->errorCode());
        }

        return $res;
    }

    /***
     * Getters and Setters
     ***/

    /**
     * @return int
     */
    public function getUserFrom(): int {
        return $this->userFrom;
    }

    /**
     * @return int
     */
    public function getFollowId(): int {
        return $this->id;
    }

    /**
     * @return int
     */
    public function getUserTo(): int {
        return $this->userTo;
    }

    /**
     * @param int $userId
     * @return Following
     */
    public function setUserFrom(int $userId): Following {
        $this->userFrom = $userId;
        $this->changed = true;
        return $this;
    }

    /**
     * @param int $userId
     * @return Following
     */
    public function setUserTo(int $userId): Following {
        $this->userTo = $userId;
        $this->changed = true;
        return $this;
    }

    /**
     * @return bool
     */
    public function getChanged(): bool {
        return $this->changed;
    }

}
