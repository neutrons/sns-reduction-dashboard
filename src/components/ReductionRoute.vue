<template>
    <div>
        <div class="col-xs-9">
            <panel>
                <span slot="title">Reductions</span>
                <!-- tabs -->
                <div class="container-fluid">

                    <ul class="nav nav-tabs nav-justified">
                        <li class="active"><a data-toggle="tab" href="#menu1">Instrument</a></li>
                        <li><a data-toggle="tab" href="#menu2">Masking</a></li>
                        <li><a data-toggle="tab" href="#menu3">Reduction</a></li>
                    </ul>

                    <form class="form-horizontal" role="form">
                        <div class="tab-content">

                            <div id="menu1" class="tab-pane fade in active">
                                <h2>Inline form: control states</h2>

                                <div class="form-group">
                                    <label for="focusedInput">Focused</label>
                                    <input class="form-control" id="focusedInput" type="text">
                                </div>
                                <div class="form-group">
                                    <label for="inputPassword">Disabled</label>
                                    <input class="form-control" id="disabledInput" type="text" disabled>
                                </div>
                                <div class="form-group has-success has-feedback">
                                    <label for="inputSuccess2">Input with success</label>
                                    <input type="text" class="form-control" id="inputSuccess2">
                                    <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                                </div>
                                <div class="form-group has-warning has-feedback">
                                    <label for="inputWarning2">Input with warning</label>
                                    <input type="text" class="form-control" id="inputWarning2">
                                    <span class="glyphicon glyphicon-warning-sign form-control-feedback"></span>
                                </div>
                                <div class="form-group has-error has-feedback">
                                    <label for="inputError2">Input with error</label>
                                    <input type="text" class="form-control" id="inputError2">
                                    <span class="glyphicon glyphicon-remove form-control-feedback"></span>
                                </div>
                            </div>
                            <div id="menu2" class="tab-pane fade">
                                <h3>Menu 2</h3>
                                <div class="form-group">
                                    <label for="sel1">Select list:</label>
                                    <select class="form-control" id="sel1">
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                    </select>
                                </div>
                                <fieldset>
                                    <label class="control-label">
                                        <strong>AB :</strong>
                                    </label>
                                    <input type="text" class="input-mini">
                                    <label class="control-label">
                                        <strong>BIS:</strong>
                                    </label>
                                    <input type="text" class="input-mini">
                                    <input type="button" value="Clear" class="btn btn-default btn-clear">
                                </fieldset>
                            </div>
                            <div id="menu3" class="tab-pane fade">
                                <h3>Menu 3</h3>
                                <p> Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Eaque ipsa quae ab
                                    illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Eaque ipsa quae ab illo inventore
                                    veritatis et quasi architecto beatae vitae dicta sunt explicabo.
                                </p>
                            </div>
                        </div>
                        <!-- form buttons -->
                        <hr/>
                        <div class="form-group" style="margin-top: 15px;">
                            <div class="col-xs-9 col-xs-offset-2">
                                <button type="button" class="btn btn-default">Default</button>
                                <button type="button" class="btn btn-primary">Primary</button>
                                <button type="button" class="btn btn-success">Success</button>
                                <button type="button" class="btn btn-info">Info</button>
                                <button type="button" class="btn btn-warning">Warning</button>
                                <button type="button" class="btn btn-danger">Danger</button>
                                <button type="button" class="btn btn-link">Link</button>
                            </div>
                        </div>
                    </form>
                </div>
            </panel>
        </div>
        <div class="col-xs-3">
            <sidebar-panel>
                <span slot="title">Reduction</span>
                <div slot="body" class="list-group">
                    <a href="#" class="list-group-item ">reduction home</a>
                    <a href="#" class="list-group-item ">new configuration</a>
                    <a href="#" class="list-group-item ">new reduction</a>
                    <a href="#" class="list-group-item disabled">see script</a>
                    <a href="#" class="list-group-item ">download python</a>
                    <a href="#" class="list-group-item ">download xml</a>
                </div>
            </sidebar-panel>
        </div>
    </div>
</template>

<script>
import Panel from './Panel.vue';
import SidebarPanel from './SidebarPanel.vue';

export default {
    name: 'ReductionRoute',
    components: {
        SidebarPanel,
        Panel,
    },
};
</script>
