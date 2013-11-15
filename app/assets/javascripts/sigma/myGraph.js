function init() {
	// Instanciate sigma.js and customize rendering :
	var sigInst = sigma.init(document.getElementById('sig')).drawingProperties({
		defaultLabelColor: '#A271BB',
		defaultLabelSize: 14,
		defaultLabelBGColor: '#A271BB',
		defaultLabelHoverColor: '#A271BB',
		labelThreshold: 6,
		defaultEdgeType: 'curve'
	}).graphProperties({
		minNodeSize: 0.5,
		maxNodeSize: 5,
		minEdgeSize: 1,
		maxEdgeSize: 1
	}).mouseProperties({
		maxRatio: 4
	});
 
	// Parse a GEXF encoded file to fill the graph
	// (requires "sigma.parseGexf.js" to be included)
	sigInst.parseGexf('assets/sigma/data.gexf');
 
	// Bind events :
	var greyColor = '#A271BB';
	sigInst.bind('overnodes',function(event){
	var nodes = event.content;
	var neighbors = {};
	sigInst.iterEdges(function(e){
		if(nodes.indexOf(e.source)<0 && nodes.indexOf(e.target)<0){
			if(!e.attr['grey']){
				e.attr['true_color'] = e.color;
				e.color = greyColor;
				e.attr['grey'] = 1;
			}
		}else{
			e.color = e.attr['grey'] ? e.attr['true_color'] : e.color;
			e.attr['grey'] = 0;
			 
			neighbors[e.source] = 1;
			neighbors[e.target] = 1;
		}
	}).iterNodes(function(n){
		if(!neighbors[n.id]){
			if(!n.attr['grey']){
				n.attr['true_color'] = n.color;
				n.color = greyColor;
				n.attr['grey'] = 1;
			}
		}else{
			n.color = n.attr['grey'] ? n.attr['true_color'] : n.color;
			n.attr['grey'] = 0;
		}
	}).draw(2,2,2);
	}).bind('outnodes',function(){
		sigInst.iterEdges(function(e){
		e.color = e.attr['grey'] ? e.attr['true_color'] : e.color;
		e.attr['grey'] = 0;
	}).iterNodes(function(n){
		n.color = n.attr['grey'] ? n.attr['true_color'] : n.color;
		n.attr['grey'] = 0;
	}).draw(2,2,2);
});
 
// Draw the graph :
sigInst.draw();
}
 
if (document.addEventListener) {
	document.addEventListener("DOMContentLoaded", init, false);
} else {
	window.onload = init;
}
