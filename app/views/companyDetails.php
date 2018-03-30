<?php
/**
 * The company details page.
 *
 * @var $company \app\models\Unit
 * @var $this \app\controllers\CompanyController
 */
$title = $company->getName();

$js_init = 'init_ajax('.$company->getId().', false)';
$container_class = 'container';
$container_id = 'container';
include "app/views/_header.phtml"
?>
<div id = "whiteTextDiv">
    <a href="<?= $_ENV['SUBDIRECTORY'] ?>/companies">Back to List</a>

    <!-- Display "Edit" and "Delete" buttons if logged in -->
    <h2><?=$company->getName()?></h2>
    <?php if ($this->is_logged_in()): ?>
    <form action="<?= $this->url('/companies/'. $company->getId() .'/edit') ?>">
        <input type="submit" value="Edit">
    </form>
    <?php else: ?>
    <p><i>Log in to edit this page.</i></p>
    <?php endif; ?>

    <h3>Members</h3>
    <section>
        <table>
            <thead>
            <tr>
                <td><b>Rank</b></td>
                <td><b>Name</b></td>
            </tr>
            </thead>
            <tbody id="members-tbody">
                <!--
                    AJAX
                -->
            </tbody>
        </table>
    </section>

    <h3>Events</h3>
    <section>
        <table>
            <thead><tr>
                <td><b>Image</b></td>
                <td><b>Name</b></td>
                <td><b>Date</b></td>
                <td><b>Description</b></td>
                <td><b>Location (Lat, Lon)</b></td>
            </tr></thead>
            <tbody id="events-tbody">
                <!--
                    AJAX
                -->
            </tbody>
        </table>
    </section>

</div>

<script src="<?= $this->url('/public/js/company_ajax.js" type="application/javascript') ?>"></script>
<?php
include "app/views/_footer.phtml"
?>